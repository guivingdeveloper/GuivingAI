//
//  RListViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/15.
//

import UIKit

class RListViewController:BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    var nd = Date()
    
    var placeDic:[String:Any]!
    
    @IBOutlet var topInfoLabel:UILabel!
    @IBOutlet var placeNameLabel:UILabel!
    
    @IBOutlet var btnAll:UIButton!
    @IBOutlet var btnNavi:UIButton!
    @IBOutlet var btnTCard:UIButton!
    
    @IBOutlet var btnStandard:UIButton!
    @IBOutlet var btnCustom:UIButton!
    
    var paramDic:[String:Any]!

    var isUpdate:Bool!
    
    var cityArray:[cityInfo]!
    
    var tourArray:[Any]!
    
    @IBOutlet var tv:UITableView!
    
    @IBAction func selectCate(_ sender: Any?) {
        let btn = sender as! UIButton
        
        self.btnAll.isSelected = false
        self.btnNavi.isSelected = false
        self.btnTCard.isSelected = false
        
        btn.isSelected = true
        self.tourArray.removeAll()
        self.callNear()
//        if btn == self.btnAll {
//            var tourAreaName = "불국사"
//            tourArray.append(tourAreaName)
//            tourAreaName = "석굴암"
//            tourArray.append(tourAreaName)
//            tourAreaName = "첨성대"
//            tourArray.append(tourAreaName)
//        }else if btn == self.btnNavi {
//            var tourAreaName = "석굴암"
//            tourArray.append(tourAreaName)
//            tourAreaName = "불국사"
//            tourArray.append(tourAreaName)
//            tourAreaName = "첨성대"
//            tourArray.append(tourAreaName)
//        }else if btn == self.btnTCard {
//            var tourAreaName = "첨성대"
//            tourArray.append(tourAreaName)
//            tourAreaName = "석굴암"
//            tourArray.append(tourAreaName)
//            tourAreaName = "불국사"
//            tourArray.append(tourAreaName)
//        }
//        self.setTopInfoLabel()
        self.tv.reloadData()
    }
    
    @IBAction func selectType(_ sender: Any?) {
        let btn = sender as! UIButton

        self.btnStandard.isSelected = false
        self.btnCustom.isSelected = false
        btn.isSelected = true

        
        self.tourArray.removeAll()
//        if btn == self.btnStandard {
//            var tourAreaName = "첨성대"
//            tourArray.append(tourAreaName)
//            tourAreaName = "석굴암"
//            tourArray.append(tourAreaName)
//            tourAreaName = "불국사"
//            tourArray.append(tourAreaName)
//        }else{
//            var tourAreaName = "석굴암"
//            tourArray.append(tourAreaName)
//            tourAreaName = "첨성대"
//            tourArray.append(tourAreaName)
//            tourAreaName = "불국사"
//            tourArray.append(tourAreaName)
//        }
        self.callNear()

//        self.setTopInfoLabel()
        self.tv.reloadData()
    }
    
    func setTopInfoLabel(){
        
        let df = DateFormatter.init()
        df.dateFormat = "MM월"
        let ds = df.string(from: nd)

        var userGender = self.paramDic["userGender"] as! String
        let userBirth = self.paramDic["userBirth"] as! String

        if userGender == "m" {
            userGender = "남성"
        }else{
            userGender = "여성"
        }

        var topInfoStr = ""
        let fromStr = self.placeDic["title"] as! String
        
        var topInfoAttStr = NSMutableAttributedString.init()
        
        if self.btnStandard.isSelected{ // 표준정보
            if self.btnAll.isSelected{
                
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds, fontSize: 20, color: UIColor.red)
                    .regular(string: " 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)
                
//                topInfoStr = String.init(format: "%@에서 %@ 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, tourArray[0] as! String)

            }else if self.btnNavi.isSelected{
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds, fontSize: 20, color: UIColor.red)
                    .regular(string: " 자동차로 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)

//                topInfoStr = String.init(format: "%@에서 %@ 자동차로 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, tourArray[0] as! String)
            }else if self.btnTCard.isSelected{
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds, fontSize: 20, color: UIColor.red)
                    .regular(string: " 대중교통으로 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)

//                topInfoStr = String.init(format: "%@에서 %@ 대중교통으로 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, tourArray[0] as! String)
            }
            
        }else{  // 개인화 정보
            if self.btnAll.isSelected{
                
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds + " ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userBirth + "대 ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userGender, fontSize: 20, color: UIColor.red)
                    .regular(string: "이 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)

                
//                topInfoStr = String.init(format: "%@에서 %@ %@대 %@이 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, userBirth, userGender, tourArray[0] as! String)
            }else if self.btnNavi.isSelected{
                
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds + " ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userBirth + "대 ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userGender, fontSize: 20, color: UIColor.red)
                    .regular(string: "이 자동차로 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)
                
//                topInfoStr = String.init(format: "%@에서 %@ %@대 %@이 자동차로 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, userBirth, userGender, tourArray[0] as! String)
            }else if self.btnTCard.isSelected{
                topInfoAttStr = NSMutableAttributedString()
                    .boldWithColor(string: fromStr, fontSize: 20, color: UIColor.red)
                    .regular(string: "에서  ", fontSize: 18)
                    .boldWithColor(string: ds + " ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userBirth + "대 ", fontSize: 20, color: UIColor.red)
                    .boldWithColor(string: userGender, fontSize: 20, color: UIColor.red)
                    .regular(string: "이 대중교통으로 가장 많이 방문한 곳은 ", fontSize: 18)
                    .boldWithColor(string: tourArray[0] as! String, fontSize: 20, color: UIColor.red)
                    .regular(string: "입니다.", fontSize: 18)

//                topInfoStr = String.init(format: "%@에서 %@ %@대 %@이 대중교통으로 가장 많이 방문한 곳은 %@ 입니다.", fromStr, ds, userBirth, userGender, tourArray[0] as! String)
            }
        }
        
        
        
//        self.topInfoLabel.attributedText = NSMutableAttributedString()
//            .regular(string: "현재 위치에서 ", fontSize: 18)
//            .bold(string: toPlaceStr, fontSize: 20)
//            .regular(string: " 까지 거리는 ", fontSize: 18)
//            .boldWithColor(string: Utility.distanceStrFromMeter(meter: NSNumber(value: distanceDouble!)), fontSize: 20, color: UIColor.red)
//            .regular(string: "이고, 예상 이동 시간은  ", fontSize: 18)
//            .boldWithColor(string: Utility.timeStrFromSec(time: durationDouble!), fontSize: 20, color: UIColor.red)
//            .regular(string: "입니다.", fontSize: 18)

        
        
//        self.topInfoLabel.text = topInfoStr
        self.topInfoLabel.attributedText = topInfoAttStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initView()
        
//        self.initNext()
        
        self.placeNameLabel.text = (self.placeDic["title"] as! String)
        tourArray = []
//        var tourAreaName = "불국사"
//        tourArray.append(tourAreaName)
//        tourAreaName = "석굴암"
//        tourArray.append(tourAreaName)
//        tourAreaName = "첨성대"
//        tourArray.append(tourAreaName)
        
        self.selectCate(self.btnAll)
        self.selectType(self.btnStandard)

        self.callNear()

        self.tv.reloadData()
        

    }
    
    func initNext(){
        
        if let sc =  self.placeDic["tourStationCode"], let si = self.placeDic["tourStationId"]{
            HServer.reqGET(urlStr: APP.HOST_URL+"tour/trans/list/\(sc)/\(si)") { (tf:Bool, any:Any?) in
                if tf == true {
                    if let resultArray = any as? [[String:Any]] {
                        self.tourArray = resultArray
                    }

                    
//                    var dic:[String:Any] = [:]
//                    var resultArray:[Any] = any as! [Any]
//
//                    if resultArray.count > 0{
//                        for (i = 0; i < resultArray.count; i++) {
//                        var dic0:[Sring:Any] = resultArray[i] as
//                    }
//
                    
//                    HServer.reqGET(urlStr: APP.HOST_URL+"tour/station/list/\(sc)/\(si)") { (tf:Bool, any:Any?) in
//                        if tf == true {
//                            print(any)
//                        }else{
//                            Utility.showAlertController(APP.mainVC, msgStr: "관광지 조회 실패", okTitle: "확인") { (UIAlertController) in
//                            }
//                        }
//                    }

                }else{
                    Utility.showAlertController(APP.mainVC, msgStr: "관광지 조회 실패", okTitle: "확인") { (UIAlertController) in
                    }
                }
            }
        }
    }
    
    func initView(){
        self.btnAll.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        self.btnNavi.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        self.btnCustom.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        self.btnStandard.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        self.btnTCard.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .selected)
        
        self.btnAll.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        self.btnNavi.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        self.btnCustom.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        self.btnStandard.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        self.btnTCard.setBackgroundColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .highlighted)
        
        self.btnAll.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        self.btnNavi.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        self.btnCustom.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        self.btnStandard.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        self.btnTCard.setBackgroundColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .normal)
        
        self.btnAll.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        self.btnNavi.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        self.btnCustom.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        self.btnStandard.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        self.btnTCard.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .selected)
        
        self.btnAll.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        self.btnNavi.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        self.btnCustom.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        self.btnStandard.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        self.btnTCard.setTitleColor(UICOLOR_FROM_RGB(r: 255, g: 255, b: 255), for: .highlighted)
        
        self.btnAll.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
        self.btnNavi.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
        self.btnCustom.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
        self.btnStandard.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
        self.btnTCard.setTitleColor(UICOLOR_FROM_RGB(r: 0, g: 166, b: 126), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RListCell = tableView.dequeueReusableCell(withIdentifier: "RListCell", for: indexPath) as! RListCell
        let str = String.init(format: "%d. %@", indexPath.row+1, tourArray[indexPath.row] as! String)
        cell.tourAreaName.text = str
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func callNear(){
        HServer.reqGET(urlStr: APP.HOST_URL+"tour/near/list/\(self.placeDic["contenttypeid"]!)/\(self.placeDic["mapx"]!)/\(self.placeDic["mapy"]!)") { (tf:Bool, any:Any?) in
            if tf == true {
//                    Utility.showAlertController(APP.mainVC, msgStr: "성공.", okTitle: "확인") { (UIAlertController) in
//                    }
                var dic:[String:Any] = [:]

                
                self.tourArray.removeAll()
                var resultArray:[Any] = any as! [Any]
                for i in 0..<resultArray.count {
                    if let dic = resultArray[i] as? [String:Any], let placeName = dic["title"] as? String {
                        
                        if placeName != self.placeDic["title"] as! String{
                            self.tourArray.append(placeName)
                        }
                        
                    }
                    
                    
                }
                self.setTopInfoLabel()
                self.tv.reloadData()
              
                
                
            }else{
                Utility.showAlertController(APP.mainVC, msgStr: "관광지 조회 실패", okTitle: "확인") { (UIAlertController) in
                }
                
            }
        }

    }
}
