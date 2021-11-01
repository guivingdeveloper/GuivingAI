//
//  TourScheduleViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/23.
//

import UIKit

class TourScheduleViewController:BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    var nd = Date()
    
    var placeDic:[String:Any]!
    
    var durationDouble:Double?
    var distanceDouble:Double?
    
    @IBOutlet var topInfoLabel:UILabel!
    @IBOutlet var placeNameLabel:UILabel!

    @IBOutlet var btnFindRoute:UIButton!

    
    var paramDic:[String:Any]!

    var isUpdate:Bool!
    
    var cityArray:[cityInfo]!
    
    var estTraffic:[String]!
    
    @IBOutlet var tv:UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        
        self.estTraffic = ["혼잡", "한산", "보통"]
        
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
