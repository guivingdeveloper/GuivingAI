//
//  MapManager.swift
//  GuivingUser
//
//  Created by JangHyun on 2020/07/28.
//  Copyright © 2020 hyun. All rights reserved.
//

import UIKit
//import Mapbox
//import MapboxDirections

import NMapsMap

protocol MapManagerDelegate {
    func mapDidChangeLocation(coor:CLLocationCoordinate2D)
    func mapIsChanging()
    func markerSelected(place:[String:Any])
}

class MapManager: NSObject, NMFMapViewCameraDelegate {
    
    var allCircles:[NMFCircleOverlay]?
    
    var allMarkers:[NMFMarker]?
    var nMapView:NMFMapView?
    
    var mapView = UIView()
    
    // 1 : naver, 2 : mapBox
    var mapType:Int = 0
    
    var isMapInit = false
    
    var delegate:MapManagerDelegate?
    
    var pickMarker:NMFMarker?
    var destMarker:NMFMarker?
    var carMarker:NMFMarker?
    
    let pathOverlay = NMFPath()
    
    var didUserInteraction = false
    
    func initMapView(frame:CGRect){
//        if let nowResDic = APP.nowResDic, let cityDic = nowResDic["cityInfo"] as? [String:Any], let cityIdx = cityDic["cityIdx"] as? NSNumber {
//
//            var flag = 2
//
//            if APP.mapCityArray != nil {
//                for mapDic in APP.mapCityArray! {
//                    let cityIdxArray = mapDic["mapCityIdx"] as! [NSNumber]
//                    if cityIdxArray.contains(cityIdx) && mapDic["mapType"] as! String == "N"{
//                        flag = 1
//                    }
//                }
//            }
//
//            //                        if cityIdx == 8 || cityIdx == 9 {   // 대한민국 => Naver Map
//            if flag == 1 {   // 대한민국 => Naver Map
                self.initNMap(frame: frame)
                self.mapType = 1
//            }else{                              // 외국 => mapBox
//                self.initBMap(frame: frame)
//                self.mapType = 2
//            }
            self.isMapInit = true
//        }else{
//            print("지도 초기화 실패")
//        }
    }
    
    func initMapView(frame:CGRect, cityIdx:NSNumber){
//        var flag = 2
//
//        if APP.mapCityArray != nil {
//            for mapDic in APP.mapCityArray! {
//                let cityIdxArray = mapDic["mapCityIdx"] as! [NSNumber]
//                if cityIdxArray.contains(cityIdx) && mapDic["mapType"] as! String == "N"{
//                    flag = 1
//                }
//            }
//        }
//
//        //                        if cityIdx == 8 || cityIdx == 9 {   // 대한민국 => Naver Map
//        if flag == 1 {   // 대한민국 => Naver Map
            self.initNMap(frame: frame)
            self.mapType = 1
//        }else{                              // 외국 => mapBox
//            self.initBMap(frame: frame)
//            self.mapType = 2
//        }

    }

    
    func mapReFrame(frame:CGRect){
//        if self.mapType == 1 {
            if nMapView != nil {
                nMapView?.frame = frame
                nMapView?.layoutIfNeeded()
                
            }
            
//        }else if self.mapType == 2 {
//            if bMapView != nil {
//                bMapView?.frame = frame
//                nMapView?.layoutIfNeeded()
//            }
//        }
        mapView.layoutIfNeeded()
    }
    
    
//    func initBMap(frame:CGRect){
//        if self.bMapView == nil {
//            let url = URL(string: "mapbox://styles/mapbox/streets-v11")
//            self.bMapView = MGLMapView(frame:frame, styleURL: url)
//            self.bMapView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            self.bMapView!.delegate = self
//            self.bMapView!.showsUserLocation = true
//            self.bMapView!.showsUserHeadingIndicator = true
//            self.mapView = self.bMapView!
//
//        }
//    }
    
    func initNMap(frame:CGRect){
        if self.nMapView == nil {
            self.nMapView = NMFMapView(frame:frame)
            self.nMapView!.addCameraDelegate(delegate: self)
            self.nMapView!.positionMode = .normal
            
            self.mapView = self.nMapView!
        }
    }
    
    func setMapCenter(lat:Double, lon:Double){
        if self.mapType == 1 {
            self.setNMapCenter(lat: lat, lon: lon)
        }else if self.mapType == 2 {
            self.setBMapCenter(lat: lat, lon: lon)
        }
    }
    
    func setBMapCenter(lat:Double, lon:Double){
//        if self.bMapView != nil {
//            self.bMapView!.setCenter(CLLocationCoordinate2DMake(lat, lon), zoomLevel: 15, animated: true)
//        }
    }
    
    
    func setNMapCenter(lat:Double, lon:Double){
        if self.nMapView != nil {
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lon))
            self.nMapView!.moveCamera(cameraUpdate)
        }
    }
    
    func addMarker(lat:Double, lon:Double, imgName:String){
//        if self.mapType == 1 {
            self.addNMarker(lat: lat, lon: lon, imgName: imgName)
//        }
//        else if self.mapType == 2{
//            self.addBMarker(lat: lat, lon: lon, imgName: imgName)
//        }
    }
    
    func addMarkers(markers:[Any]){
        if self.mapType == 1 {
            self.addNMarkers(markers: markers)
        }else if self.mapType == 2{
//            self.addBMarker(lat: lat, lon: lon, imgName: imgName)
        }
    }
    
    func removeAllMarkers(){
        if self.mapType == 1 {
            self.removeNAllMarkers()
        }else if self.mapType == 2{
//            self.addBMarker(lat: lat, lon: lon, imgName: imgName)
        }
    }
    

    
//    func addBMarker(lat:Double, lon:Double, imgName:String){
//        if self.bMapView != nil {
//            let location = CLLocationCoordinate2D.init(latitude: lat, longitude: lon)
//            self.drawPin(coor: location, imgName: imgName)
//
//            //            let pick = CustomPointAnnotation(coordinate: location, title: nil, subtitle: nil)
//            //            pick.reuseIdentifier = imgName
//            //            pick.image = UIImage(named: imgName)
//            //            self.bMapView!.addAnnotation(pick)
//        }
//    }
    
    func addNMarker(lat:Double, lon:Double, imgName:String){
        if self.nMapView != nil {
            if imgName == "icon_dest_marker" {
                if destMarker == nil {
                    destMarker = NMFMarker()
                    destMarker!.position = NMGLatLng(lat: lat, lng: lon)
                    destMarker!.iconImage = NMFOverlayImage(name: imgName)
                    destMarker!.mapView = self.nMapView!
                }else{
                    destMarker!.position = NMGLatLng(lat: lat, lng: lon)
                }
            }
            if imgName == "icon_pick_marker" {
                if pickMarker == nil {
                    pickMarker = NMFMarker()
                    pickMarker!.position = NMGLatLng(lat: lat, lng: lon)
                    pickMarker!.iconImage = NMFOverlayImage(name: imgName)
                    pickMarker!.mapView = self.nMapView!
                }else{
                    pickMarker!.position = NMGLatLng(lat: lat, lng: lon)
                }
            }
            if imgName == "icon_car_marker" {
                if carMarker == nil {
                    carMarker = NMFMarker()
                    carMarker!.position = NMGLatLng(lat: lat, lng: lon)
                    carMarker!.iconImage = NMFOverlayImage(name: imgName)
                    carMarker!.mapView = self.nMapView!
                }else{
                    carMarker!.position = NMGLatLng(lat: lat, lng: lon)
                }
            }
//            let marker1 = NMFMarker()
//            marker1.position = NMGLatLng(lat: lat, lng: lon)
//            marker1.iconImage = NMFOverlayImage(name: imgName)
//            marker1.mapView = self.nMapView!
        }
    }
    
    func addNMarkers(markers:[Any]){
        if self.nMapView != nil {
            if self.allMarkers == nil {
                self.allMarkers = []
            }

            if let markerList:[[String:Any]] = markers as? [[String:Any]]{
                for dic:[String:Any] in markerList{
                    if let addr1 = dic["addr1"] as? String, let addr2 = dic["addr2"] as? String, let title = dic["title"] as? String{
                        var lon:NSNumber?
                        var lat:NSNumber?
                        if let l = dic["mapx"] as? NSNumber{
                            lon = l
                        }
                        if let ll = dic["mapx"] as? String {
                            lon = NSNumber.init(value: Double(ll) ?? 0)
                        }
                        
                        if let l = dic["mapy"] as? NSNumber{
                            lat = l
                        }
                        if let ll = dic["mapy"] as? String {
                            lat = NSNumber.init(value: Double(ll) ?? 0)
                        }
                        
                        let marker1 = NMFMarker()
                        marker1.position = NMGLatLng(lat: lat as! Double, lng: lon as! Double)
                        
                        var markerName = ""
                        if let contenttypeid = dic["contenttypeid"] as? NSNumber {
                            let cid = "\(contenttypeid)"
                            if cid == CATE_CODE_SHOPPING {
                                markerName = "marker_cate_shopping_on"
                            }
                            if cid == CATE_CODE_FOOD {
                                markerName = "marker_cate_food_on"
                            }
                            if cid == CATE_CODE_CULTURE {
                                markerName = "marker_cate_culture_on"
                            }
                            if cid == CATE_CODE_TOUR {
                                markerName = "marker_cate_tour_on"
                            }
                            if cid == CATE_CODE_REPORTS {
                                markerName = "marker_cate_reports_on"
                            }
                        
                            marker1.iconImage = NMFOverlayImage(name: markerName)
                        }
                        
                        marker1.touchHandler = { (overlay) in
                            self.delegate?.markerSelected(place: dic)
                            print("마커 클릭됨")
                            return true
                        }
                        marker1.mapView = self.nMapView!
                        marker1.captionText = dic["title"] as! String
                        self.allMarkers!.append(marker1)
                    }
                }
            }
            
            
        }
            
            
        print("allMarkersCount = \(self.allMarkers?.count)")
            
    }
    
    func removeNAllMarkers(){
        if self.nMapView != nil {
            if self.allMarkers == nil {return}
            for mk:NMFMarker in self.allMarkers! {
                mk.mapView = nil
            }
            self.allMarkers?.removeAll()
        }
    }
    
    func addNCircle(circles:[Any]){
        if self.allCircles == nil {
            self.allCircles = []
        }
        
        if let circleList:[[String:Any]] = circles as? [[String:Any]]{
            for dic:[String:Any] in circleList{
                var lon:NSNumber?
                var lat:NSNumber?
                
                if let l = dic["mapx"] as? NSNumber{
                    lon = l
                }
                if let ll = dic["mapx"] as? String {
                    lon = NSNumber.init(value: Double(ll) ?? 0)
                }
                
                if let l = dic["mapy"] as? NSNumber{
                    lat = l
                }
                if let ll = dic["mapy"] as? String {
                    lat = NSNumber.init(value: Double(ll) ?? 0)
                }
                
                let circle = NMFCircleOverlay()
                
                circle.center = NMGLatLng(lat: lat as! Double, lng: lon as! Double)
                
                var cnt = 0
                if let navList = dic["navVOList"] as? [[String:Any]]{
                    let dayStr = "01"
                    for navVO in navList {
                        if let navHour = navVO["navHour"] as? NSNumber, let navCount = navVO["navCount"] as? NSNumber{
                            let df = DateFormatter.init()
                            df.dateFormat = "HH"
                            df.timeZone = TimeZone.autoupdatingCurrent
                            let now = Date.init()
                            let nowHour = df.string(from: now)
                            if navHour.stringValue == nowHour {
                                cnt = navCount.intValue
                            }
                        }
                    }
                }

//                print("cnt = %d, alpha = %f",cnt, Float(cnt+1)/30)
                
                print("cnt = %d, alpha = %f",cnt, Float(cnt+1)/10)
                
//                let color = UIColor.init(red: 200/255, green: 10/255, blue: 10/255, alpha: CGFloat(Float(cnt+1))/30)
                let color = UIColor.init(red: 200/255, green: 10/255, blue: 10/255, alpha: CGFloat(Float(cnt+1))/10)
//                let color = UIColor.red
//                color.withAlphaComponent(CGFloat(Float(cnt))/50)
                circle.fillColor = color
                circle.outlineColor = color
                
//                if cnt > 5 {
//                    circle.fillColor = UIColor.green
//                }else if cnt > 25{
//                    circle.fillColor = UIColor.yellow
//                }else{
//                    circle.fillColor = UIColor.white
//                }
                circle.outlineWidth = 1
                
                circle.radius = 300

                circle.mapView = self.nMapView!
                self.allCircles!.append(circle)
            }
        }
    }
    
    func addCircles(circles:[Any]){
        if self.mapType == 1 {
            self.addNCircle(circles: circles)
        }else if self.mapType == 2{
//            self.addBMarker(lat: lat, lon: lon, imgName: imgName)
        }
    }
    func removeAllCircles(){
        if self.mapType == 1 {
            self.removeNAllCircles()
        }else if self.mapType == 2{
//            self.addBMarker(lat: lat, lon: lon, imgName: imgName)
        }
    }

    func removeNAllCircles(){
        if self.nMapView != nil {
            if self.allCircles == nil {return}
            for circle:NMFCircleOverlay in self.allCircles! {
                circle.mapView = nil
            }
            self.allCircles?.removeAll()
        }
    }

    func callPath(sLocation:CLLocationCoordinate2D, eLocation:CLLocationCoordinate2D, completion:@escaping(NSNumber?, NSNumber?, Error?) -> Void){
//        if self.mapType == 1 {
            self.callNPath(sLocation: sLocation, eLocation: eLocation, completion:completion)
//        }else if self.mapType == 2{
//            self.callBPath(sLocation: sLocation, eLocation: eLocation, completion:completion)
//        }
    }
    
    
//    func callBPath(sLocation:CLLocationCoordinate2D, eLocation:CLLocationCoordinate2D, completion:@escaping(NSNumber?, NSNumber?, Error?) -> Void){
//        if self.bMapView == nil {return}
//        let origin = Waypoint(coordinate: sLocation, coordinateAccuracy: -1, name: "Start")
//        let destination = Waypoint(coordinate: eLocation, coordinateAccuracy: -1, name: "Finish")
//        let options = RouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
//        _ = Directions.shared.calculate(options, completionHandler: { (waypoints, routes, error) in
//            if error != nil {
//                completion(nil, nil, error)
//                return
//            }
//            let directionRouts = routes?.first
//
//            let coordicateBounds = MGLCoordinateBoundsMake(eLocation, sLocation)
//            let insets = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
//            let routeCam = self.bMapView!.cameraThatFitsCoordinateBounds(coordicateBounds, edgePadding: insets)
//            self.bMapView!.setCamera(routeCam, animated: true)
//            self.drawRoute(route: routes!.first!)
//
//            completion(NSNumber(value:directionRouts!.distance), NSNumber.init(value:Double((directionRouts?.expectedTravelTime)!)), nil)
//
//        })
//    }
    
    
//    func drawRoute(route:Route){
//        guard route.coordinates!.count > 0 else{return}
//
//        var routeCoordinates = route.coordinates!
//        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: route.coordinateCount)
//
//        if let source = self.bMapView!.style?.source(withIdentifier: "route-source") as? MGLShapeSource{
//            source.shape = polyline
//        }else{
//            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
//
//            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
//
//            lineStyle.lineColor = NSExpression(forConstantValue: POLYLINE_STROKE_COLOR)
//            lineStyle.lineWidth = NSExpression(forConstantValue: POLYLINE_LINE_WIDTH)
//
//            self.bMapView!.style?.addSource(source)
//            self.bMapView!.style?.addLayer(lineStyle)
//        }
//    }
    
    func callNPath(sLocation:CLLocationCoordinate2D, eLocation:CLLocationCoordinate2D, completion:@escaping(NSNumber?, NSNumber?, Error?) -> Void){
        if self.nMapView == nil {return}
        let urlStr = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving?start=\(sLocation.longitude),\(sLocation.latitude)&goal=\(eLocation.longitude),\(eLocation.latitude)"
        
        HServer.reqNMap(urlStr: urlStr) { (tf:Bool, any:Any?) in
            if tf == false {
                let err = NSError.init()
                completion(nil, nil, err)
                return
            }
            if let traoptimalDic = any as? [String:Any] ,let pathArray = traoptimalDic["path"] as? [Any]{
                
                var minLat = sLocation.latitude
                var maxLat = eLocation.latitude
                var minLon = sLocation.longitude
                var maxLon = eLocation.longitude
                
                self.pathOverlay.path = NMGLineString(points: [
                    NMGLatLng(lat: sLocation.latitude, lng: sLocation.longitude),
                    NMGLatLng(lat: eLocation.latitude, lng: eLocation.longitude),
                ])
                
//                if sLocation.latitude < minLat {
//                    minLat = sLocation.latitude
//                }
//                if sLocation.latitude > maxLat {
//                    maxLat = sLocation.latitude
//                }
//                if sLocation.longitude < minLon {
//                    minLon = sLocation.longitude
//                }
//                if sLocation.longitude > maxLon {
//                    maxLon = sLocation.longitude
//                }
//
//                if eLocation.latitude < minLat {
//                    minLat = eLocation.latitude
//                }
//                if eLocation.latitude > maxLat {
//                    maxLat = eLocation.latitude
//                }
//                if eLocation.longitude < minLon {
//                    minLon = eLocation.longitude
//                }
//                if eLocation.longitude > maxLon {
//                    maxLon = eLocation.longitude
//                }
                
                let pArray = self.pathOverlay.path
                
                for i in 0..<pathArray.count{
                    if let path = pathArray[i] as? [Any]{
                        if let lat = path[1] as? NSNumber, let lan = path[0] as? NSNumber {
                            pArray.insertPoint(NMGLatLng(lat: lat.doubleValue, lng: lan.doubleValue), at: UInt(i))
                            
                            if lat.doubleValue < minLat {
                                minLat = lat.doubleValue
                            }
                            if lat.doubleValue > maxLat {
                                maxLat = lat.doubleValue
                            }
                            if lan.doubleValue < minLon {
                                minLon = lan.doubleValue
                            }
                            if lan.doubleValue > maxLon {
                                maxLon = lan.doubleValue
                            }
                            
                        }
                    }
                }
                pArray.removePoint(NMGLatLng(lat: sLocation.latitude, lng: sLocation.longitude))
                pArray.removePoint(NMGLatLng(lat: eLocation.latitude, lng: eLocation.longitude))
                
                
                self.pathOverlay.mapView = nil
                
                
                self.pathOverlay.path = pArray
                self.pathOverlay.mapView = self.nMapView!
                
                if self.didUserInteraction == false{
//                    let nmgBounds = NMGLatLngBounds(southWest: NMGLatLng(lat: sLocation.latitude, lng: sLocation.longitude), northEast: NMGLatLng(lat: eLocation.latitude, lng: eLocation.longitude))
                    let nmgBounds = NMGLatLngBounds(southWest: NMGLatLng(lat: minLat, lng: minLon), northEast: NMGLatLng(lat: maxLat, lng: maxLon))
                    let cameraUpdate = NMFCameraUpdate(fit: nmgBounds, paddingInsets: UIEdgeInsets.init(top: 80, left: 50, bottom: 30, right: 50))
                    self.nMapView?.moveCamera(cameraUpdate)
                }
                

                self.pathOverlay.color = POLYLINE_STROKE_COLOR
                self.pathOverlay.width = POLYLINE_LINE_WIDTH
                
                if let smr = traoptimalDic["summary"] as? [String:Any], let distance = smr["distance"] as? NSNumber, let duration = smr["duration"] as? NSNumber{
                    let d = duration.doubleValue
                    completion(distance, NSNumber.init(value: d/1000), nil)
                }else{
                    let err = NSError.init()
                    completion(nil, nil, err)
                }
            }
        }
    }
    
    
    
//    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
//        if let point = annotation as? CustomPointAnnotation,
//            let image = point.image,
//            let reuseIdentifier = point.reuseIdentifier {
//
//            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
//                // The annotatation image has already been cached, just reuse it.
//                return annotationImage
//            } else {
//                // Create a new annotation image.
//                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
//            }
//        }
//
//        // Fallback to the default marker image.
//        return nil
//    }
    
    
//    func drawPin(coor:CLLocationCoordinate2D, imgName:String){
//        let point = MGLPointAnnotation()
//        point.coordinate = coor
//        // Create a data source to hold the point data
//        if let shapeSource = self.bMapView!.style?.source(withIdentifier: imgName+"source") as? MGLShapeSource {
//            shapeSource.shape = point
//        }else{
//            let shapeSource = MGLShapeSource(identifier: imgName+"source", shape: point, options: nil)
//            // Create a style layer for the symbol
//            let shapeLayer = MGLSymbolStyleLayer(identifier: imgName+"style", source: shapeSource)
//
//            // Add the image to the style's sprite
//            if let image = UIImage(named: imgName) {
//                self.bMapView!.style?.setImage(image, forName: imgName+"symbol")
//            }
//
//            // Tell the layer to use the image in the sprite
//            shapeLayer.iconImageName = NSExpression(forConstantValue: imgName+"symbol")
//
//            // Add the source and style layer to the map
//            self.bMapView!.style?.addSource(shapeSource)
//            self.bMapView!.style?.addLayer(shapeLayer)
//        }
//    }
    
//    func mapView(_ mapView: MGLMapView, regionIsChangingWith reason: MGLCameraChangeReason) {
//        self.delegate?.mapIsChanging()
//    }
//
//    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
//        let coor = mapView.centerCoordinate
//        self.delegate?.mapDidChangeLocation(coor: coor)
//    }
//
//    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
//        if reason == -1 {
//            self.didUserInteraction = true
//        }
//    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let coor = CLLocationCoordinate2D.init(latitude: mapView.cameraPosition.target.lat, longitude: mapView.cameraPosition.target.lng)
        self.delegate?.mapDidChangeLocation(coor: coor)
        
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        self.delegate?.mapIsChanging()
    }
}
