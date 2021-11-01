//
//  TourDetailViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/13.
//

import UIKit

protocol DrivingTourDetailDelegate {
    func detailDestPlaceDic(place:[String:Any])
    func selTraffic(place:[String:Any])
}



class TourDetailViewController: BaseViewController {
    
    var delegate:DrivingTourDetailDelegate?

    var placeDic:[String:Any]!
    
    var isFromList = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var imgScrollView: UIScrollView!
    
    
    var imgArray:[[String:Any]]?
    var detailInfo:[String:Any]?
    
    var vTarget:UIViewController?

    func remakeImgScrollView(){
        if self.imgArray == nil || self.imgArray?.count == 0 {
            return
        }
        
        self.imgScrollView.isPagingEnabled = true
        self.imgScrollView.alwaysBounceVertical = false
        self.imgScrollView.bounces = false
        
        let numberOfViews = self.imgArray!.count
        
        for i in 0..<numberOfViews {
            let xOrigin = Double(i) * Double(self.imgScrollView.frame.width)
            DispatchQueue.main.async {
                let dic = self.imgArray![i] as? [String:Any]
                let imgView:UIImageView = UIImageView.init(frame: CGRect.init(x: CGFloat(xOrigin), y: 0.0, width: self.imgScrollView.frame.width, height: self.imgScrollView.frame.height))

//                let imgSmaillUrlSTr = dic["smallimageurl"] as? String
                
                if let urlStr = dic!["originimgurl"] as? String, let _ = try? Data.init(contentsOf: URL.init(string: Utility.imgUrlAdded(str: urlStr))!){
                    Utility.downloadImage(str: Utility.imgUrlAdded(str: urlStr), completion: { (img:UIImage?, err:Error?) in
                        DispatchQueue.main.async {
                            imgView.image = img
                        }
                    })
                }
                self.imgScrollView.showsHorizontalScrollIndicator = false
                self.imgScrollView.addSubview(imgView)

            }
            let w = Double(self.imgArray!.count) * Double(self.imgScrollView.frame.width)
            let h = self.imgScrollView.frame.height
            self.imgScrollView.contentSize = CGSize.init(width: Double(w), height: Double(h))
            self.imgScrollView.showsHorizontalScrollIndicator = true
            
//            CGSize.init(width: Double(self.imgArray!.count) * Double(self.imgScrollView.frame.width), height: self.imgScrollView.frame.height)
//            cell.contentView.addSubview(cell.imgScrollview)
//            self.layoutIfNeeded()
        }

        
    }
    
    func callImgList(){
//        var sortType = "S"
        let contentTypeId = placeDic["contenttypeid"] as? NSNumber
        let contentId = placeDic["contentid"] as? NSNumber
        let reqUrl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailImage?serviceKey=\(KEY_VISIT_KOREA_API)&MobileOS=IOS&MobileApp=GUIVING_TEST&&contentTypeId=\(contentTypeId!)&contentId=\(contentId!)&_type=json"
        HServer.reqVisit(urlStr: reqUrl) { (tf:Bool, any:Any) in
             if tf == true {
                self.imgArray = any as? [[String:Any]]
                self.remakeImgScrollView()
            }else{
            }
        }
    }
    func callDetail(){
        let contentTypeId = placeDic["contenttypeid"] as? NSNumber
        let contentId = placeDic["contentid"] as? NSNumber
        let reqUrl = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?serviceKey=\(KEY_VISIT_KOREA_API)&MobileOS=IOS&MobileApp=GUIVING_TEST&&contentTypeId=\(contentTypeId!)&contentId=\(contentId!)&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&transGuideYN=Y&_type=json"
        HServer.reqVisitDetail(urlStr: reqUrl) { (tf:Bool, any:Any) in
            if tf == true {
                if let detailDic = any as? [String:Any] {
                    if let overViewText = detailDic["overview"] as? String{
                        
//                        self.overViewTextView.attributedText = overViewText.htmlToAttributedString
                        self.overViewTextView.text = overViewText.htmlToString
                    }
                    if let addrStr = detailDic["addr1"] as? String{
                        self.addrLabel.text = addrStr
                    }
                }
            }else{
            }
        }
    }
    
    @IBAction func selectDest(_ sender: Any) {
        if self.isFromList == true {
            self.dismiss(animated: false) {
                self.vTarget?.dismiss(animated: false, completion: {
                    self.delegate?.detailDestPlaceDic(place: self.placeDic)
                })
            }
            
        }else{
            self.dismiss(animated: false) {
                self.delegate?.detailDestPlaceDic(place: self.placeDic)
            }
        }
        
    }
    
    @IBAction func addBookmark(_ sender: Any) {
        self.dismiss(animated: false) {
            self.delegate?.selTraffic(place: self.placeDic)
        }
//        let btn = sender as! UIButton
//        if btn.isSelected == true {
//            btn.isSelected = false
//            if var bookmarkArray = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_FULL) as? [[String:Any]], var bookmarkList = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_LIST) as? [NSNumber] {
//                var tmpArray = bookmarkArray
//                for i in 0..<tmpArray.count{
//                    let dic = tmpArray[i]
//                    if (dic["contentid"] as! NSNumber).isEqual(to: self.placeDic["contentid"] as! NSNumber)  == true {
//                        tmpArray.remove(at: i)
//                        break
//                    }
//                }
//                bookmarkArray = tmpArray
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkArray, key: DEFAULT_BOOKMARK_FULL)
//
//                var tmpArray2 = bookmarkList
//                for i in 0..<tmpArray2.count{
//                    let str = tmpArray2[i] as! NSNumber
//                    if (str == placeDic["contentid"] as! NSNumber) {
//                        tmpArray2.remove(at: i)
//                        break
//                    }
//                }
//                bookmarkList = tmpArray2
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkList, key: DEFAULT_BOOKMARK_LIST)
//
//            }
//        }else{
//            btn.isSelected = true
//            if var bookmarkArray = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_FULL) as? [[String:Any]], var bookmarkList = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_LIST) as? [NSNumber]{
//                bookmarkArray.append(self.placeDic)
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkArray, key: DEFAULT_BOOKMARK_FULL)
//                bookmarkList.append(placeDic["contentid"] as! NSNumber)
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkList, key: DEFAULT_BOOKMARK_LIST)
//
//
//            }else{
//                let bookmarkArray:[[String:Any]] = [self.placeDic]
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkArray, key: DEFAULT_BOOKMARK_FULL)
//                let bookmarkList:[NSNumber] = [placeDic["contentid"] as! NSNumber]
//                BUNDLE_SET_OBJECT_FOR_KEY(id: bookmarkList, key: DEFAULT_BOOKMARK_LIST)
//
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callDetail()
        self.callImgList()
        
        self.nameLabel.text = placeDic["title"] as! String
        let cateNum = placeDic["contenttypeid"] as? NSNumber
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
        self.typeLabel.text = cs
        self.addrLabel.text = placeDic["addr1"] as! String
        
        let contentid = self.placeDic["contentid"] as! NSNumber
        if let bookmarkList = BUNDLE_OBJECT_FOR_KEY(key: DEFAULT_BOOKMARK_LIST) as? [NSNumber]{
            if bookmarkList.contains(contentid){
                self.btnBookmark.isSelected = true
            }else{
                self.btnBookmark.isSelected = false
            }
        }

        // Do any additional setup after loading the view.
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
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
