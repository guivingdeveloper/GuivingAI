//
//  InfoViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/10/07.
//

import UIKit
import Charts


struct tourInfo{
    var baseYmd:Int
    var touNum:NSNumber
}


class InfoViewController: BaseViewController {
    
    @IBOutlet var lineChart:LineChartView?
    
    @IBOutlet var dateTF:UITextField?
    
    @IBAction func search(_ sender: Any) {
        self.callData()

    }
    
//    @IBOutlet var barChart:BarChartView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.makeGraph()
        self.callData()
    }
    
    func callData(){
//        let contentTypeId = placeDic["contenttypeid"] as? NSNumber
//        let contentId = placeDic["contentid"] as? NSNumber
        let dateStr = dateTF?.text ?? "202011"
        let startYmd = dateStr + "01"
        let endYmd = dateStr + "30"
        
        let reqUrl = "http://api.visitkorea.or.kr/openapi/service/rest/DataLabService/metcoRegnVisitrDDList?serviceKey=\(KEY_VISIT_KOREA_API)&MobileOS=ETC&MobileApp=GUIVING_TEST&startYmd=\(startYmd)&endYmd=\(endYmd)&_type=json&numOfRows=2000"

        
        HServer.reqVisit(urlStr: reqUrl) { (tf:Bool, any:Any) in
             if tf == true {
                 
                 if let resultArray = any as? [[String:Any]]{
                     var localArray:[[String:Any]] = []
                     var foreinArray:[[String:Any]] = []
                     var overSeaArray:[[String:Any]] = []
                     
//                     var localCntArray:[NSNumber] = []
//                     var foreinCntArray:[NSNumber] = []
//                     var overSeaCntArray:[NSNumber] = []
//                     
                     var localCntArray:[tourInfo] = []
                     var foreinCntArray:[tourInfo] = []
                     var overSeaCntArray:[tourInfo] = []
                     
                     
                     var tourInfo = tourInfo(baseYmd: 0, touNum: 0)

                     for dic:[String:Any] in resultArray {
                         if let areaCode = dic["areaCode"]  as? NSNumber{
                             if areaCode == 11 {
                                 if let tourDivCd = dic["touDivCd"] as? NSNumber{
                                     if tourDivCd == 1 {
                                         localArray.append(dic)
                                         if let tourCnt = dic["touNum"] as? NSNumber, let baseYmd = dic["baseYmd"] as? NSNumber{
                                             let baseYmdStr = "\(baseYmd)"
                                             let subStr = baseYmdStr.substring(from: 6, to: 7)
                                             
                                             tourInfo.baseYmd = Int(subStr) ?? 0
                                             tourInfo.touNum = tourCnt
                                             localCntArray.append(tourInfo)
//                                             localCntArray.append(tourCnt)
                                         }
                                     }else if tourDivCd == 2 {
                                         foreinArray.append(dic)
                                         if let tourCnt = dic["touNum"] as? NSNumber, let baseYmd = dic["baseYmd"] as? NSNumber{
                                             let baseYmdStr = "\(baseYmd)"
                                             let subStr = baseYmdStr.substring(from: 6, to: 7)
                                             
                                             tourInfo.baseYmd = Int(subStr) ?? 0
                                             tourInfo.touNum = tourCnt
                                             foreinCntArray.append(tourInfo)

//                                             foreinCntArray.append(tourCnt)
                                         }
                                     }else if tourDivCd == 3 {
                                         overSeaArray.append(dic)
                                         if let tourCnt = dic["touNum"] as? NSNumber, let baseYmd = dic["baseYmd"] as? NSNumber{
                                             let baseYmdStr = "\(baseYmd)"
                                             let subStr = baseYmdStr.substring(from: 6, to: 7)
                                             
                                             tourInfo.baseYmd = Int(subStr) ?? 0
                                             tourInfo.touNum = tourCnt
                                             overSeaCntArray.append(tourInfo)

//                                             overSeaCntArray.append(tourCnt)
                                         }
                                     }
                                 }
                             }
                         }
                     }
                     
//                     let newArr = localCntArray.sorted { (lhs:tourInfo, rhs:tourInfo) in
//                         return lhs.deadline < rhs.deadline
//                     }
                     // ... or even:
                     let localCntArrays = localCntArray.sorted { (lhs, rhs) in return lhs.baseYmd < rhs.baseYmd }
                     let overSeaCntArrays = overSeaCntArray.sorted { (lhs, rhs) in return lhs.baseYmd < rhs.baseYmd }
                     let foreinCntArrays = foreinCntArray.sorted { (lhs, rhs) in return lhs.baseYmd < rhs.baseYmd }

                     
                     
                     var lineChartEntry1 = [ChartDataEntry]() // graph 에 보여줄 data array
                        
                     // chart data array 에 데이터 추가
                     for i in 0..<localCntArray.count {
                         if let ti = localCntArrays[i] as? tourInfo {
                             let value = ChartDataEntry(x: Double(ti.baseYmd), y: Double(ti.touNum))
                             lineChartEntry1.append(value)
                         }
                         
                     }
                     
                     let line1 = LineChartDataSet(entries: lineChartEntry1, label: "현지인")
                     line1.colors = [NSUIColor.blue]
                        
                     var lineChartEntry2 = [ChartDataEntry]() // graph 에 보여줄 data array
                        
                     // chart data array 에 데이터 추가
                     for i in 0..<foreinCntArray.count {
                         if let ti = foreinCntArrays[i] as? tourInfo {
                             let value = ChartDataEntry(x: Double(ti.baseYmd), y: Double(ti.touNum))
                             lineChartEntry2.append(value)
                         }
                         
                     }
                     
                     let line2 = LineChartDataSet(entries: lineChartEntry2, label: "외지인")
                     line2.colors = [NSUIColor.red]

                     var lineChartEntry3 = [ChartDataEntry]() // graph 에 보여줄 data array
                        
                     // chart data array 에 데이터 추가
                     for i in 0..<overSeaCntArray.count {
                         if let ti = overSeaCntArrays[i] as? tourInfo {
                             let value = ChartDataEntry(x: Double(ti.baseYmd), y: Double(ti.touNum))
                             lineChartEntry3.append(value)
                         }
                     }
                     
                     let line3 = LineChartDataSet(entries: lineChartEntry3, label: "외국인")
                     line3.colors = [NSUIColor.green]
                     
                     line1.drawCirclesEnabled = false
                     line2.drawCirclesEnabled = false
                     line3.drawCirclesEnabled = false

                     line1.drawValuesEnabled = false
                     line2.drawValuesEnabled = false
                     line3.drawValuesEnabled = false

                     
                      let data = LineChartData()
                      data.addDataSet(line1)
                      data.addDataSet(line2)
                      data.addDataSet(line3)
                     
                     
                     
//                     let bar1 = BarChartDataSet(entries: lineChartEntry1, label: "현지인")
//                     let bar2 = BarChartDataSet(entries: lineChartEntry2, label: "외지인")
//                     let bar3 = BarChartDataSet(entries: lineChartEntry3, label: "외국인")

//                     let data = BarChartData()
//                     data.addDataSet(bar1)
//                     data.addDataSet(bar2)
//                     data.addDataSet(bar3)
                     
                        
                     if let lc = self.lineChart {
                         lc.data = data
                                 }

                     
                 }
                 
                
            }else{
            }
            LoadingIndicator.shared.hide()

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
extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
