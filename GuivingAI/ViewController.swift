//
//  ViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/07/28.
//

import UIKit
import CoreLocation

class ViewController: BaseViewController,CLLocationManagerDelegate, MapManagerDelegate, DrivingTourDetailDelegate {
    func mapDidChangeLocation(coor: CLLocationCoordinate2D) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate{
            if userLocationDegrees == nil{
                print("First Time")
                userLocationDegrees = manager.location?.coordinate

//                self.mapMng.setMapCenter(lat: coor.latitude, lon: coor.longitude)
//                self.callVisitInfo()
                
            }
        }
    }

    var paramDic:[String:Any]!

    // Map, Tour Place
    
    @IBOutlet weak var btnCateAll: UIButton!
    @IBOutlet weak var btnCateTour: UIButton!
    @IBOutlet weak var btnCateCulture: UIButton!
    @IBOutlet weak var btnCateFood: UIButton!
    @IBOutlet weak var btnCateReports: UIButton!
    @IBOutlet weak var btnCateShopping: UIButton!
    @IBOutlet weak var btnCateBookmark: UIButton!
    
    @IBOutlet weak var btnReFind: UIButton!
    
    @IBOutlet weak var btnDetailBookmark:UIButton!
    var isRefind = false

    
    @IBOutlet weak var detailIV: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailCate: UILabel!
    @IBOutlet weak var detailDistance: UILabel!
    @IBOutlet weak var detailAddr: UILabel!
    
    
    @IBOutlet weak var detailInfoView: UIView!
    @IBOutlet weak var categoryView: UIView!
    
    var totalDataArray: [[String:Any]] = []
    
    var tourDic:[String:Any] = [:]
    var cultureDic:[String:Any] = [:]
    var foodDic:[String:Any] = [:]
    var reportsDic:[String:Any] = [:]
    var shoppingDic:[String:Any] = [:]
    var bookmarkDic:[String:Any] = [:]
    
    var selectedCate = CATE_ARRAY
    
    var nowDetail:[String:Any] = [:]
    
    @IBOutlet weak var btnGoToCenter: UIButton!

    
    var locationManager = CLLocationManager()
    var userLocationDegrees:CLLocationCoordinate2D?

    @IBOutlet weak var mapView: UIView!

    var isLoaded = false
    let mapMng = MapManager.init()

    
    
    func mapIsChanging() {
        
    }
    
    @IBAction func goToCenter(){
        if let ul = userLocationDegrees {
            mapMng.setMapCenter(lat: ul.latitude, lon: ul.longitude)
        }
    }

    @IBAction func reFind(_ sender: Any) {
//        self.isRefind = true

        self.mapMng.removeNAllCircles()
        
        for dic:[String:Any] in self.totalDataArray as! [[String:Any]]{
//            let dic:[String:Any] = self.totalDataArray[0] as! [String:Any]
            for cateCode:String in self.selectedCate{
                if let arr:[[String:Any]] = dic[cateCode] as? [[String:Any]]{
                    mapMng.addCircles(circles: arr)
                }
            }
        }

//        self.callVisitInfo()
    }

    func markerSelected(place: [String : Any]) {
        self.detailInfoView.isHidden = false

        self.nowDetail = place
        let dic = place
        
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
            
            self.detailTitle.text = title
            
            let loc = CLLocationCoordinate2D.init(latitude: lat!.doubleValue, longitude: lon!.doubleValue)
            if var distance = userLocationDegrees?.distanceTo(coordinate: loc){
                distance = distance/1000
                distance = round(distance * 100) / 100
                
                self.detailDistance.text = "\(distance) km"
                
            }else{
                self.detailDistance.text = "현재 위치 파악 불가"
            }
            
            self.detailAddr.text = addr1
            let cateNum = dic["contenttypeid"] as? NSNumber
            let cateString = "\(cateNum!)"
            var cs = ""
            switch cateString {
            case CATE_CODE_FOOD:
                cs = "음식점"
            case CATE_CODE_TOUR:
                cs = "관광지"
            case CATE_CODE_REPORTS:
                cs = "레포츠"
            case CATE_CODE_CULTURE:
                cs = "문화시설"
            case CATE_CODE_SHOPPING:
                cs = "쇼핑"
            default:
                cs = ""
            }
            self.detailCate.text = cs
            if let urlStr = dic["firstimage2"] as? String, let imageData = try? Data.init(contentsOf: URL.init(string: Utility.imgUrlAdded(str: urlStr))!){
                self.detailIV.image = UIImage.init(data: imageData)
            }

            
            let contentid = self.nowDetail["contentid"] as! NSNumber
            if let bookmarkList = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_LIST) as? [NSNumber]{
                if bookmarkList.contains(contentid){
                    self.btnDetailBookmark.isSelected = true
                }else{
                    self.btnDetailBookmark.isSelected = false
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initMapView()
        
        // View Layout
        view.layoutSubviews()
        mapView.layoutIfNeeded()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoaded == true {return}
        
        locationManager.requestWhenInUseAuthorization() //권한 요청
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()

        isLoaded = true
        
        self.detailInfoView.isHidden = true

        // 위치 정보를 받아오는 경우에 두번 콜 되는 경우에 대한 처리 필요
        callVisitInfo()

    }

    func initMapView(){

        if mapMng.isMapInit == false{
            self.mapMng.initMapView(frame: CGRect.init(x: 0, y: 0, width: mapView.frame.width, height: mapView.frame.height))
            self.mapView.addSubview(mapMng.mapView)
            self.mapView.bringSubviewToFront(self.btnGoToCenter)
            self.mapView.bringSubviewToFront(self.btnReFind)
            mapMng.delegate = self
            
            var lat = ""
            var lon = ""
            
//            if let latLon = userLocationDegrees {
//                lat = "\(latLon.latitude)"
//                lon = "\(latLon.longitude)"
//
//            }else{
                lat = dummyLat
                lon = dummyLon
//            }
            
            self.mapMng.setMapCenter(lat: Double.init(lat) ?? 35.85631070975238, lon: Double.init(lon) ?? 129.224878100072)

        }

    }
    func callVisitInfo(){
        var lat = ""
        var lon = ""
        
        if self.isRefind == true{
            if let latLon = userLocationDegrees {
                lat = "\(latLon.latitude)"
                lon = "\(latLon.longitude)"
    
            }else{
                lat = dummyLat
                lon = dummyLon
                userLocationDegrees = CLLocationCoordinate2D.init(latitude: Double.init(lat) ?? 35.85631070975238, longitude: Double.init(lon) ?? 129.224878100072)
            }
        }else{
            lat = dummyLat
            lon = dummyLon
        }
        
        let totalCnt = CATE_ARRAY.count
        var cnt = 0;
        self.totalDataArray.removeAll()
        for var code:String in CATE_ARRAY{
//            let code = "12"
            var contentTypeId = code

            LoadingIndicator.shared.show()

                HServer.reqGET(urlStr: APP.HOST_URL+"tour/list/\(contentTypeId)/\(lon)/\(lat)") { (tf:Bool, any:Any?) in
                    if tf == true {
    //                    Utility.showAlertController(APP.mainVC, msgStr: "성공.", okTitle: "확인") { (UIAlertController) in
    //                    }
                        var dic:[String:Any] = [:]

                        
                        var resultArray:[Any] = any as! [Any]

                        cnt = cnt + 1
                        dic[code] = resultArray

                        if code == "12"{
                            self.tourDic = dic
                        }
                        if code == "14"{
                            self.cultureDic = dic
                        }
                        if code == "39"{
                            self.foodDic = dic
                        }
                        if code == "28"{
                            self.reportsDic = dic
                        }
                        if code == "38"{
                            self.shoppingDic = dic
                        }
                        
                        self.totalDataArray.append(dic)

                        if cnt == totalCnt {
                            self.callDone()
                        }
                        
                        
                    }else{
                        Utility.showAlertController(APP.mainVC, msgStr: "관광지 조회 실패", okTitle: "확인") { (UIAlertController) in
                        }
                        
                    }
                }
            

            
            
//            var sortType = "S"
//            var contentTypeId = code
//            var reqUrl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/locationBasedList?serviceKey=\(KEY_VISIT_KOREA_API)&numOfRows=10&pageNo=1&MobileOS=IOS&MobileApp=GUIVING_TEST&arrange=\(sortType)&contentTypeId=\(contentTypeId)&mapX=\(lon)&mapY=\(lat)&radius=20000&listYN=Y&modifiedtime=&_type=json"
//            HServer.reqVisit(urlStr: reqUrl) { (tf:Bool, any:Any) in
//                if tf == true {
////                    Utility.showAlertController(APP.mainVC, msgStr: "성공.", okTitle: "확인") { (UIAlertController) in
////                    }
//                    var dic:[String:Any] = [:]
//
//                    cnt = cnt + 1
//                    dic[code] = any
//
//                    if code == "12"{
//                        self.tourDic = dic
//                    }
//                    if code == "14"{
//                        self.cultureDic = dic
//                    }
//                    if code == "39"{
//                        self.foodDic = dic
//                    }
//                    if code == "28"{
//                        self.reportsDic = dic
//                    }
//                    if code == "38"{
//                        self.shoppingDic = dic
//                    }
//
//                    self.totalDataArray.append(dic)
//
//                    if cnt == totalCnt {
//                        self.callDone()
//                    }
//
//
//                }else{
//                    Utility.showAlertController(APP.mainVC, msgStr: reqUrl, okTitle: "확인") { (UIAlertController) in
//                    }
//
//                }
//            }
        }
    }
    
    func callDone(){
        print("callDone")
        print(self.totalDataArray)
        LoadingIndicator.shared.hide()

        if self.isRefind == true{
            self.isRefind = false
            

            mapMng.removeAllMarkers()
            self.mapMng.removeNAllCircles()
            for dic:[String:Any] in self.totalDataArray as! [[String:Any]]{
    //            let dic:[String:Any] = self.totalDataArray[0] as! [String:Any]
                for cateCode:String in self.selectedCate{
                    if let arr:[[String:Any]] = dic[cateCode] as? [[String:Any]]{
                        mapMng.addMarkers(markers: arr)
//                        mapMng.addCircles(circles: arr)
                    }
                }
            }

        }else{
            let btn = UIButton.init()
            btn.tag = 1
            selectCate(btn)
            
        }
    }
    
    @IBAction func selectCate(_ sender: Any) {
        let btn = sender as! UIButton

        if btn.tag == 1 {
            if self.btnCateAll.isSelected == true{

                self.selectedCate.removeAll()
                
                self.btnCateAll.isSelected = false
                self.btnCateTour.isSelected = false
                self.btnCateCulture.isSelected = false
                self.btnCateFood.isSelected = false
                self.btnCateReports.isSelected = false
                self.btnCateShopping.isSelected = false
                self.btnCateBookmark.isSelected = false

//                self.totalDataArray.removeAll()
            }else{
                self.btnCateAll.isSelected = true
                self.btnCateTour.isSelected = true
                self.btnCateCulture.isSelected = true
                self.btnCateFood.isSelected = true
                self.btnCateReports.isSelected = true
                self.btnCateShopping.isSelected = true
                self.btnCateBookmark.isSelected = true
                
//                self.totalDataArray.append(self.tourDic)
//                self.totalDataArray.append(self.cultureDic)
//                self.totalDataArray.append(self.foodDic)
//                self.totalDataArray.append(self.reportsDic)
//                self.totalDataArray.append(self.shoppingDic)
                self.selectedCate = CATE_ARRAY
            }
        }
        
        if btn.tag == 12 {
            if self.btnCateTour.isSelected == true{
                self.btnCateTour.isSelected = false
                
                for i in 0..<self.selectedCate.count{
                    let a = self.selectedCate[i]
                    if a == CATE_CODE_TOUR {
                        self.selectedCate.remove(at: i)
                        break
                    }
                    
                }
                
                
//                for i in 0..<self.totalDataArray.count{
//                    let dic = self.totalDataArray[i]
//                    if dic.keys.contains(CATE_CODE_TOUR) {
//                        self.totalDataArray.remove(at: i)
//                    }
//                }
                
            }else{
                self.btnCateTour.isSelected = true
                self.selectedCate.append(CATE_CODE_TOUR)
//                self.totalDataArray.append(self.tourDic)
            }
        }
        if btn.tag == 14 {
            if self.btnCateCulture.isSelected == true{
                self.btnCateCulture.isSelected = false
                for i in 0..<self.selectedCate.count{
                    let a = self.selectedCate[i]
                    if a == CATE_CODE_CULTURE {
                        self.selectedCate.remove(at: i)
                        break
                    }   
                }
//
//                for i in 0..<self.totalDataArray.count{
//                    let dic = self.totalDataArray[i]
//                    if dic.keys.contains(CATE_CODE_CULTURE) {
//                        self.totalDataArray.remove(at: i)
//                    }
//                }
            }else{
                self.btnCateCulture.isSelected = true
                self.selectedCate.append(CATE_CODE_CULTURE)

//                self.totalDataArray.append(self.cultureDic)

            }
        }
        if btn.tag == 39 {
            if self.btnCateFood.isSelected == true{
                self.btnCateFood.isSelected = false
                for i in 0..<self.selectedCate.count{
                    let a = self.selectedCate[i]
                    if a == CATE_CODE_FOOD {
                        self.selectedCate.remove(at: i)
                        break
                    }
                    
                }
//
//                for i in 0..<self.totalDataArray.count{
//                    let dic = self.totalDataArray[i]
//                    if dic.keys.contains(CATE_CODE_FOOD) {
//                        self.totalDataArray.remove(at: i)
//                    }
//                }
            }else{
                self.btnCateFood.isSelected = true
                self.selectedCate.append(CATE_CODE_FOOD)

//                self.totalDataArray.append(self.foodDic)

            }
        }
        if btn.tag == 28 {
            if self.btnCateReports.isSelected == true{
                self.btnCateReports.isSelected = false
                for i in 0..<self.selectedCate.count{
                    let a = self.selectedCate[i]
                    if a == CATE_CODE_REPORTS {
                        self.selectedCate.remove(at: i)
                        break
                    }
                    
                }
//
//                for i in 0..<self.totalDataArray.count{
//                    let dic = self.totalDataArray[i]
//                    if dic.keys.contains(CATE_CODE_REPORTS) {
//                        self.totalDataArray.remove(at: i)
//                    }
//                }
            }else{
                self.btnCateReports.isSelected = true
                self.selectedCate.append(CATE_CODE_REPORTS)

//                self.totalDataArray.append(self.reportsDic)
            }
        }
        if btn.tag == 38 {
            if self.btnCateShopping.isSelected == true{
                self.btnCateShopping.isSelected = false
                for i in 0..<self.selectedCate.count{
                    let a = self.selectedCate[i]
                    if a == CATE_CODE_SHOPPING {
                        self.selectedCate.remove(at: i)
                        break
                    }
                    
                }
//
//                for i in 0..<self.totalDataArray.count{
//                    let dic = self.totalDataArray[i]
//                    if dic.keys.contains(CATE_CODE_SHOPPING) {
//                        self.totalDataArray.remove(at: i)
//                    }
//                }
            }else{
                self.btnCateShopping.isSelected = true
                self.selectedCate.append(CATE_CODE_SHOPPING)

//                self.totalDataArray.append(self.shoppingDic)
            }
        }
        if btn.tag == 100 {
            if self.btnCateBookmark.isSelected == true{
                self.btnCateBookmark.isSelected = false
            }else{
                self.btnCateBookmark.isSelected = true
            }
        }
        
        if self.btnCateTour.isSelected == true && self.btnCateCulture.isSelected == true && self.btnCateFood.isSelected == true && self.btnCateReports.isSelected == true && self.btnCateShopping.isSelected == true && self.btnCateBookmark.isSelected == true {
            self.btnCateAll.isSelected = true
        }
        
        mapMng.removeAllMarkers()
        self.mapMng.removeNAllCircles()
        for dic:[String:Any] in self.totalDataArray as! [[String:Any]]{
//            let dic:[String:Any] = self.totalDataArray[0] as! [String:Any]
            for cateCode:String in self.selectedCate{
                if let arr:[[String:Any]] = dic[cateCode] as? [[String:Any]]{
                    mapMng.addMarkers(markers: arr)
//                    mapMng.addCircles(circles: arr)
                }
            }
        }
    }

    @IBAction func goToDetail(_ sender: Any) {
        let dic = self.nowDetail
        let vc:TourDetailViewController = MainSB.instantiateViewController(withIdentifier: "TourDetailViewController") as! TourDetailViewController
        vc.delegate = self
        vc.isFromList = true
        vc.placeDic = dic
        vc.vTarget = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false) {}
    }
    
    func detailDestPlaceDic(place: [String : Any]) {
        self.destPlaceDic(place: place)
    }
    
    func destPlaceDic(place: [String : Any]) {
        self.selectFromTour(place: place)
    }
    
    @objc func selectFromTour(place:[String:Any]){
        if let lon = place["mapx"] as? NSNumber, let lat = place["mapy"] as? NSNumber, let addr1 = place["addr1"] as? String, let title = place["title"] as? String{
            
            
            var dic:[String:Any] = [:]
            dic["placeLatitude"] = lat
            dic["placeLongitude"] = lon
            dic["placeName"] = title
            dic["placeAddr"] = addr1
            
            let lat = CLLocationDegrees(dic["placeLatitude"] as! Double)
            let lon = CLLocationDegrees(dic["placeLongitude"] as! Double)
            
            let con:RListViewController = MainSB.instantiateViewController(withIdentifier: "RListViewController") as! RListViewController
            con.placeDic = place
            con.paramDic = self.paramDic
            APP.nav.pushViewController(con, animated: true);

            // 선택 후 액션으로 수정 필요

//            self.isDestSelected = true
//            self.nowTripDic["eplaceVO"] = dic
//            destBtn.setTitle(dic["placeName"] as? String, for: .normal)
//
//            self.mapMng.addMarker(lat: lat, lon: lon, imgName: "icon_dest_marker")
//
//            if self.isPickSelected == true && self.isDestSelected == true{
//                self.perform(#selector(self.doneAction), with: nil, afterDelay: 0.1)
//            }
        }
    }
    

    @IBAction func selectDestFromDetail(_ sender: Any) {
        self.selectFromTour(place: self.nowDetail)
    }

    func selTraffic(place: [String : Any]) {
        self.realGoToEst(place: place)
    }

    @IBAction func goToEst(_ sender: Any) {
        let place = self.nowDetail
        self.realGoToEst(place: place)
        
    }
    
    func realGoToEst(place:[String:Any]){
        if let lon = place["mapx"] as? NSNumber, let lat = place["mapy"] as? NSNumber, let addr1 = place["addr1"] as? String, let title = place["title"] as? String{
            
            
            // 현재 위치에서 목적지까지의 거리 및 예상 이동시간 산정

            if let ul = userLocationDegrees {
                
                let sLat = CLLocationDegrees(ul.latitude as! Double)
                let sLon = CLLocationDegrees(ul.longitude as! Double)
                let eLat = CLLocationDegrees(lat as! Double)
                let eLon = CLLocationDegrees(lon as! Double)
                let sLocation = CLLocationCoordinate2D.init(latitude: sLat, longitude: sLon)
                let eLocation = CLLocationCoordinate2D.init(latitude: eLat, longitude: eLon)

                self.mapMng.callPath(sLocation: sLocation, eLocation: eLocation) { (distance:NSNumber?, duration:NSNumber?, err:Error?) in
                    if err != nil {
//                        self.distanceLabel.text = "경로 정보 수신에 실패했습니다."
                        LoadingIndicator.shared.hide()
                        return
                    }else{
                        let durationDouble = duration!.doubleValue
                        let distanceDouble = distance!.doubleValue
//                            self.distanceLabel.text = Utility.timeStrFromSec(time: d)
//                            self.durationLabel.text = Utility.distanceStrFromMeter(meter: distance!)
//                            self.distanceNum = distance!
//                            self.doneBtn.isEnabled = true
                            //                self.bMapView.setCamera(routeCam, animated: true)
                        
                        
                        
                        var dic:[String:Any] = [:]
                        dic["placeLatitude"] = lat
                        dic["placeLongitude"] = lon
                        dic["placeName"] = title
                        dic["placeAddr"] = addr1
                        
                        _ = CLLocationDegrees(dic["placeLatitude"] as! Double)
                        _ = CLLocationDegrees(dic["placeLongitude"] as! Double)
                        
                        let con:TourEstViewController = MainSB.instantiateViewController(withIdentifier: "TourEstViewController") as! TourEstViewController
                        con.placeDic = place
                        con.paramDic = self.paramDic
                        con.durationDouble = durationDouble
                        con.distanceDouble = distanceDouble
                        APP.nav.pushViewController(con, animated: true);
                    }
                    LoadingIndicator.shared.hide()
                }
            }else{
                print("사용자의 현재 위치를 받아올 수 없음")
            }


            
        }
    }


}
