//
//  TourEstViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/19.
//

import UIKit

class TourEstViewController:BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    var nd = Date()
    
    var placeDic:[String:Any]!
    
    var navVOList:[[String:Any]]?
    
    var durationDouble:Double?
    var distanceDouble:Double?
    
    @IBOutlet var topInfoLabel:UILabel!
    @IBOutlet var placeNameLabel:UILabel!

    @IBOutlet var btnFindRoute:UIButton!

    
    var paramDic:[String:Any]!

    var isUpdate:Bool!
    
    var cityArray:[cityInfo]!
    
    var estTraffic:[String] = []
    
    @IBOutlet var tv:UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cnt = 0
        var cnt1 = 0
        var cnt2 = 0
        if let navList = self.placeDic["navVOList"] as? [[String:Any]]{
            self.navVOList = navList
            if let _ = self.navVOList {
                for navVO in self.navVOList! {
                    if let navHour = navVO["navHour"] as? NSNumber, let navCount = navVO["navCount"] as? NSNumber{
                        let df = DateFormatter.init()
                        df.dateFormat = "HH"
                        df.timeZone = TimeZone.autoupdatingCurrent
                        let now = Date.init()
                        let nowHour = df.string(from: now)
                        let hour1 = df.string(from: now.addingTimeInterval(3600))
                        let hour2 = df.string(from: now.addingTimeInterval(3600*2))

                        if navHour.stringValue == nowHour {
                            cnt = navCount.intValue
                        }else if navHour.stringValue == hour1 {
                            cnt1 = navCount.intValue
                        }else if navHour.stringValue == hour2 {
                            cnt2 = navCount.intValue
                        }

                    }
                }
            }
        }
        
        let normalValue = 1
        let heavyValue = 5
        
        self.estTraffic.removeAll()
        var rStr = "한산"
        if cnt > normalValue {
            rStr = "보통"
        }else if cnt > heavyValue {
            rStr = "복잡"
        }
        self.estTraffic.append(rStr)
        if cnt1 > normalValue {
            rStr = "보통"
        }else if cnt1 > heavyValue {
            rStr = "복잡"
        }
        self.estTraffic.append(rStr)
        if cnt2 > normalValue {
            rStr = "보통"
        }else if cnt2 > heavyValue {
            rStr = "복잡"
        }
        self.estTraffic.append(rStr)
        
        
        self.initView()
        
//        self.estTraffic = ["혼잡", "한산", "보통"]
        
        self.placeNameLabel.text = (self.placeDic["title"] as! String)
        
        
//        let df = DateFormatter.init()
//        df.dateFormat = "MM월"
//        let ds = df.string(from: nd)
//
//        var userGender = self.paramDic["userGender"] as! String
//        let userBirth = self.paramDic["userBirth"] as! String
//
//        if userGender == "m" {
//            userGender = "남성"
//        }else{
//            userGender = "여성"
//        }

        var topInfoStr = ""
        let toPlaceStr = self.placeDic["title"] as! String

        
        topInfoStr = String.init(format: "현재 위치에서 %@까지 거리는 %@이고, 예상 이동 시간은 %@ 입니다.", toPlaceStr, Utility.distanceStrFromMeter(meter: NSNumber(value: distanceDouble!)), Utility.timeStrFromSec(time: durationDouble!))

        
        self.topInfoLabel.attributedText = NSMutableAttributedString()
            .regular(string: "현재 위치에서 ", fontSize: 18)
            .bold(string: toPlaceStr, fontSize: 20)
            .regular(string: " 까지 거리는 ", fontSize: 18)
            .boldWithColor(string: Utility.distanceStrFromMeter(meter: NSNumber(value: distanceDouble!)), fontSize: 20, color: UIColor.red)
            .regular(string: "이고, 예상 이동 시간은  ", fontSize: 18)
            .boldWithColor(string: Utility.timeStrFromSec(time: durationDouble!), fontSize: 20, color: UIColor.red)
            .regular(string: "입니다.", fontSize: 18)
        
        
           
//        self.topInfoLabel.text = topInfoStr
        
        self.tv.reloadData()
    }
    
    func initView(){
        self.btnFindRoute.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        self.btnFindRoute.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        self.btnFindRoute.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        self.btnFindRoute.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        self.btnFindRoute.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        self.btnFindRoute.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.estTraffic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TourEstCell = tableView.dequeueReusableCell(withIdentifier: "TourEstCell", for: indexPath) as! TourEstCell
        


        var timeStr = ""
        if indexPath.row == 0 {
            timeStr = "현재"
        }else{
            timeStr = String.init(format: "%d시간 후", indexPath.row)
        }
//        let str = String.init(format: "%@   %@", timeStr, self.estTraffic[indexPath.row] as! String)
        
        cell.estTimeLabel.text = timeStr
        cell.trafficLabel.text = self.estTraffic[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func findRoute(){
        
        let lat = self.placeDic["mapx"] as! NSNumber
        let lon = self.placeDic["mapy"] as! NSNumber

        let encodedHost = (self.placeDic["title"] as! String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlString = "nmap://navigation?dlat=\(lat.stringValue)&dlng=\(lon.stringValue)&dname=\(encodedHost!)&appname=com.guiving.GuivingAI"
        
         if let encode = encodedHost {
            if let url = URL.init(string: urlString){
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
           }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
