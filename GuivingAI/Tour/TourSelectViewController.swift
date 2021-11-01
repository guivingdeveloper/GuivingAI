//
//  TourSelectViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/13.
//

import UIKit

struct cityInfo{
    var name:String
    var isActive:Bool
}

class TourSelectViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var paramDic:[String:Any]!

    var isUpdate:Bool!
    
    var cityArray:[cityInfo]!
    
    @IBOutlet var tv:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityArray = []
        var cityDic = cityInfo(name: "경주", isActive: true)
        cityArray.append(cityDic)
        cityDic = cityInfo(name: "서울", isActive: true)
        cityArray.append(cityDic)
        cityDic = cityInfo(name: "전주", isActive: false)
        cityArray.append(cityDic)
        cityDic = cityInfo(name: "제주", isActive: false)
        cityArray.append(cityDic)
        
        print(cityArray)
        
        self.tv.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CityCell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityCell
        cell.initCell(cityInfo: cityArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let baseAge = ( indexPath.row + 1 ) * 10
//        let ageStr = String.init(format: "%i", baseAge)
        self.paramDic["cityInfo"] = cityArray[indexPath.row]
        print("paramDic=",self.paramDic)
        

        if indexPath.row == 0 {
            // 경주
            dummyLat = "35.85631070975238"
            dummyLon = "129.224878100072"
        }else{
            // 코엑스
//            dummyLat = "37.51006"
//            dummyLon = "127.06007"
            // 강남
            dummyLat = "37.49697977522117"
            dummyLon = "127.03120331618723"
        }
        

        


        let con:ViewController = MainSB.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        con.paramDic = self.paramDic
        APP.nav.pushViewController(con, animated: true);
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
