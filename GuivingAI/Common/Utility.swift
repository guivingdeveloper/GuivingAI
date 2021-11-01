//
//  Utility.swift
//  GuivingUser
//
//  Created by Nonghyup on 2018. 11. 7..
//  Copyright © 2018년 hyun. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

//let imageCache = NSCache<AnyObject, AnyObject>()
//
//extension UIImageView{
//    func donwloadImage(str:String){
//        let url = NSURL(string: str)
//        
//        image = nil
//        
//        if let imageFromCache = imageCache.object(forKey: str as AnyObject) as? UIImage{
//            self.image = imageFromCache
//            return
//        }
//    }
//}

extension NSMutableAttributedString {

    var fontSize: CGFloat {
        return 14
    }
    var boldFont: UIFont {
        return UIFont(name: "NanumSquareOTFBold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
    }
    var normalFont: UIFont {
        return UIFont(name: "NanumSquareOTFRegular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
    var extraBoldFont:UIFont {
        return UIFont(name: "NanumSquareExtraBold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
    func boldWithColor(string: String, fontSize: CGFloat, color:UIColor) -> NSMutableAttributedString {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font:font,
                                                         .foregroundColor:color]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .foregroundColor: UIColor.white,
            .backgroundColor: UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font: normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

extension CLLocationCoordinate2D {
    func distanceTo(coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let thisLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let otherLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        return thisLocation.distance(from: otherLocation)
    }
}

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

extension String {
    func compareVersion(_ version: String?) -> ComparisonResult {
        var a:String = "a"
        let version1 = components(separatedBy: ".")
        let version2 = version?.components(separatedBy: ".")
        for i in 0..<version1.count {
            var value1: Int = 0
            var value2: Int = 0
            if i < version1.count {
                value1 = Int(version1[i])!
            }
            if i < (version2?.count ?? 0) {
                value2 = Int(version2![i])!
            }
            if value1 == value2 {
                continue
            } else {
                if value1 > value2 {
                    return .orderedDescending
                } else {
                    return .orderedAscending
                }
            }
        }
        return .orderedSame
    }
}

extension UIImageView{
    var circled : UIImageView{
        self.layer.cornerRadius = self.frame.width / 2;
//        self.layer.borderWidth = 2
//        self.layer.borderColor = UIColor.red.cgColor
        self.clipsToBounds = true
        return self
    }
}


@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text!.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

class LoadingIndicator: UIView {
    
    /// ActivityIndicator
    let loader = UIActivityIndicatorView()
    let v: UIView = UIView()
    /// Shared Instance
    static let shared: LoadingIndicator = {
        let instance = LoadingIndicator()
        return instance
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepared()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Design Indicator and Adding subView to Window
    func prepared() {
        
        //        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.backgroundColor = UIColor.clear
        self.frame = (UIApplication.shared.windows.first?.frame)!
        v.frame = CGRect.init(x: 0, y: 0, width: 63, height: 63)
        v.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.06)
        v.center = UIApplication.shared.windows.first!.center
        v.layer.cornerRadius = 5.0
        print(String(format: "vFrame = %@", NSCoder.string(for: v.frame)))
        print(String(format: "vFrame = %@", NSCoder.string(for: v.frame)))
        loader.frame = CGRect.init(x: 0, y: 0, width: 63, height: 63)
        loader.style = .gray
        //        loader.center = v.center
        //        loader.color = UIColor.red
        v.addSubview(loader)
        //        loader.color = UIColor.blue
        print(String(format: "vFrame = %@", NSCoder.string(for: v.frame)))
        print(String(format: "lFrame = %@", NSCoder.string(for: loader.frame)))
        self.addSubview(v)
        
    }
    
    /// Show Indicator View with animation
    func show() {
        let application = UIApplication.shared.delegate as! AppDelegate
        // application.window?.rootViewController?.view.addSubview(self)
        
        application.window?.addSubview(self)
        
        loader.startAnimating()
        
        v.bringSubviewToFront((application.window?.rootViewController?.view)!)
        loader.bringSubviewToFront((application.window?.rootViewController?.view)!)
        
        // UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /// Hide Indicator View with animation
    func hide() {
        self.removeFromSuperview()
        loader.stopAnimating()
        
        // if UIApplication.shared.isIgnoringInteractionEvents {
        // UIApplication.shared.endIgnoringInteractionEvents()
        // }
    }
    
}
extension NSError {
    static func generalParsingError(domain: String) -> Error {
        return NSError(domain: domain, code: 400, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Error retrieving data", comment: "General Parsing Error Description")])
    }
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

/* 볼 수도있는 쓰레기코드
 //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 //
 //        let empty = textField.text?.isEmpty ?? true
 //        if(empty) {
 //            textField.text = string.uppercased()
 //            if textField == fNameTF {
 //                if lNameTF?.text != nil && lNameTF?.text != ""{
 //                    nextBtn?.isEnabled = true
 //                }
 //            }
 //            if textField == lNameTF {
 //                if fNameTF?.text != nil && fNameTF?.text != ""{
 //                    nextBtn?.isEnabled = true
 //                }
 //            }
 //            return false
 //        }
 //        return true
 //    }
 */
typealias alertCallBack = (UIAlertController) -> Void



class Utility: NSObject {
    
    class func showAlertController(_ target: UIViewController?, msgStr: String?, okTitle: String?, okAction:@escaping alertCallBack) {
        self.showAlertController(target, titleStr: "알림", msgStr: msgStr, okTitle: okTitle, cancelTitle: nil, okAction: okAction, cancelAction: nil)
    }

    
    class func showAlertController(_ target: UIViewController?, titleStr: String?, msgStr: String?, okTitle: String?, okAction:@escaping alertCallBack) {
        self.showAlertController(target, titleStr: titleStr, msgStr: msgStr, okTitle: okTitle, cancelTitle: nil, okAction: okAction, cancelAction: nil)
    }
    
    
    class func showAlertController(_ target: UIViewController?, titleStr: String?, msgStr: String?, okTitle: String?, cancelTitle: String?, okAction: @escaping alertCallBack, cancelAction:alertCallBack?) {
        let con = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .alert)
        if cancelTitle != nil {
            let _cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: { action in
                cancelAction!(con)
            })
            con.addAction(_cancelAction)
        }
        let _okAction = UIAlertAction(title: okTitle, style: .default, handler: { action in
            okAction(con)
        })
        con.addAction(_okAction)

        target?.present(con, animated: nil != nil)
    }
    
    class func colorWithHexString(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    class func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    class func localToUTC(date:String, dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.dateFormat = dateFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    class func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    class func UTCToLocal(date:String, dateFormatter:DateFormatter) -> String {
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = dateFormatter.dateFormat
        return dateFormatter.string(from: dt!)
    }
    
    class func dateStrToUTCStr(dateStr:String, dateFormatter:DateFormatter?, cityCode:String) -> String
    {
        var timeZoneId = ""
        if cityCode == "MNL" || cityCode == "CEB" || cityCode == "BOR"
        {
            timeZoneId = "Asia/Manila"
        }
//        else if countryCode == "KR"
//        {
//            timeZoneId = "Asia/Seoul"
//        }
        else
        {
            timeZoneId = "Asia/Seoul"
        }
        var fmt = DateFormatter.init()
        if dateFormatter != nil {
            fmt = dateFormatter!
        }else{
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }

        let timezone = TimeZone.init(identifier: timeZoneId)
        fmt.timeZone = timezone
        let date = fmt.date(from: dateStr)
        fmt.timeZone = TimeZone(abbreviation: "UTC")

        let ret = fmt.string(from: date!)
        return ret
    }
    
    class func dateStrToUTCStr(dateStr:String, dateFormatter:DateFormatter?, cityIdx:NSNumber) -> String
    {
        var timeZoneId = ""
        if cityIdx == 4 || cityIdx == 5 || cityIdx == 6
        {
            timeZoneId = "Asia/Manila"
        }
//        else if countryCode == "KR"
//        {
//            timeZoneId = "Asia/Seoul"
//        }
        else
        {
            timeZoneId = "Asia/Seoul"
        }
        var fmt = DateFormatter.init()
        if dateFormatter != nil {
            fmt = dateFormatter!
        }else{
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }

        let timezone = TimeZone.init(identifier: timeZoneId)
        fmt.timeZone = timezone
        let date = fmt.date(from: dateStr)
        fmt.timeZone = TimeZone(abbreviation: "UTC")

        let ret = fmt.string(from: date!)
        return ret
    }

    
    
    
    class func dateStrUtcToLocal(dateStr:String, dateFormatter:DateFormatter?, cityCode:String) -> String
    {
        var timeZoneId = ""
        if cityCode == "MNL" || cityCode == "CEB" || cityCode == "BOR"
        {
            timeZoneId = "Asia/Manila"
        }
            //        else if countryCode == "KR"
            //        {
            //            timeZoneId = "Asia/Seoul"
            //        }
        else
        {
            timeZoneId = "Asia/Seoul"
        }
        var fmt = DateFormatter.init()
        if dateFormatter != nil {
            fmt = dateFormatter!
        }else{
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        
        
        fmt.timeZone = TimeZone(abbreviation: "UTC")
        let dt = fmt.date(from: dateStr)
        
        fmt.timeZone = TimeZone.init(identifier: timeZoneId)
//        let localDate = fmt.date(from: dateStr)
//
        let ret = fmt.string(from: dt!)
        return ret
    }
    
    class func dateStrUtcToLocal(dateStr:String, dateFormatter:DateFormatter?, cityIdx:NSNumber) -> String
    {
        var timeZoneId = ""
        if cityIdx == 4 || cityIdx == 5 || cityIdx == 6
        {
            timeZoneId = "Asia/Manila"
        }
            //        else if countryCode == "KR"
            //        {
            //            timeZoneId = "Asia/Seoul"
            //        }
        else
        {
            timeZoneId = "Asia/Seoul"
        }
        var fmt = DateFormatter.init()
        if dateFormatter != nil {
            fmt = dateFormatter!
        }else{
            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        
        
        
        fmt.timeZone = TimeZone(abbreviation: "UTC")
        let dt = fmt.date(from: dateStr)
        
        fmt.timeZone = TimeZone.init(identifier: timeZoneId)
        //        let localDate = fmt.date(from: dateStr)
        //
        let ret = fmt.string(from: dt!)
        return ret
    }

    
    //  스크린 사이즈, 해상도에 맞는 스플래시 이미지명을 리턴
    class func splashImageFromDevice() -> String? {
        
        let height: CGFloat = UIScreen.main.bounds.size.height
        let width: CGFloat = UIScreen.main.bounds.size.width
        let scale: CGFloat = UIScreen.main.scale
        
        var imgName = ""
        
        //iPhone
        if width == 320 {
            if height == 480 {
                imgName = "Splash_4_640x960"
            } else {
                imgName = "Splash_5_640x1136"
            }
        } else if width == 375 {
            if height == 667 {
                imgName = "Default_667h"
            } else {
                imgName = "Default_Portrait-2436h"
            }
        } else if width == 414 {
            if height == 896 {
                if scale == 3.0 {
                    imgName = "Default_Portrait-2688h"
                } else {
                    imgName = "Default_Portrait-1792h"
                }
            } else {
                imgName = "Default_Portrait-736h"
            }
        }
        return imgName;
    }
    
    // 숫자 천단위 표기
    class func formattedNumber(_beforeNum: String?, _unitString: String?) -> String? {
        if _unitString == "KRW" || _unitString == "원"{
            var v = Double(_beforeNum!)
            v = round(v!)

            return String.init(format: "%@ %@",_unitString!, self.formattedNumber(_beforeNum:String
                .init(format: "%.0f", v!))!)
        }

        return String.init(format: "%@ %@", _unitString!, self.formattedNumber(_beforeNum: _beforeNum)!)
    }
    
    class func formattedNumber(_beforeNum: NSNumber?, _unitString: String?) -> String? {
        if _unitString == "KRW" || _unitString == "원"{
            var v = Double(truncating: _beforeNum!)
            v = round(v)
            return String.init(format: "%@ %@",_unitString! , self.formattedNumber(_beforeNum:String
                .init(format: "%.0f", v))!)
        }
        return String.init(format: "%@ %@", _unitString!, self.formattedNumber(_beforeNum: _beforeNum)!)
    }

    
    class func formattedNumber(_beforeNum: String?) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        let returnStr = "\(numberFormatter.string(from: NSNumber(value: Double(_beforeNum ?? "") ?? 0.0)) ?? "")"
        
        return returnStr
    }
    
    class func formattedNumber(_beforeNum: NSNumber?) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        let returnStr = "\(numberFormatter.string(from: _beforeNum!) ?? "")"
        
        return returnStr
    }

    
//    class func formattedExNumber(_beforeNum: NSNumber?) -> String? {
//
//        let v = _beforeNum?.doubleValue
//        let exRate = APP.exVO["excRate"] as! NSNumber
//        let vv:Double = v! * Double(truncating: exRate)
//
//        let exSimbol = APP.exVO["excSymbol"] as! String
//        if exSimbol == "KRW" {
//            return String.init(format: "%@%@", self.formattedNumber(_beforeNum:String
//                .init(format: "%.0f", vv))!,exSimbol)
//        }
//
//        return String.init(format: "%@%@", self.formattedNumber(_beforeNum:String
//            .init(format: "%f", vv))!,exSimbol)
//    }
//
//
//    class func formattedExNumber(_beforeNum: String?) -> String? {
//
//        let v = Double(_beforeNum!)
//        let exRate = APP.exVO["excRate"] as! NSNumber
//        let vv:Double = v! * Double(truncating: exRate)
//
//        let exSimbol = APP.exVO["excSymbol"] as! String
//        if exSimbol == "KRW" {
//            return String.init(format: "%@%@", self.formattedNumber(_beforeNum:String
//                .init(format: "%.0f", vv))!,exSimbol)
//        }
//
//        return String.init(format: "%@%@", self.formattedNumber(_beforeNum:String
//            .init(format: "%f", vv))!,exSimbol)
//    }
//
//    class func formattedExNumber(_beforeNum: String!,exRate:NSNumber!) -> String? {
//
//        let v = Double(_beforeNum!)
//        let vv:Double = v! * Double(truncating: exRate)
//
//        let exSimbol = APP.exVO["excSymbol"] as! String
//
//        return String.init(format: "%@%@", self.formattedNumber(_beforeNum:String
//            .init(format: "%f", vv))!,exSimbol)
//    }
    
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    class func isValidPW(password: String) -> Bool {
//        if (password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil) {
////            errorMsg += "one upper case letter"
//            return false
//        }
        if (password.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil) {
//            errorMsg += ", one lower case letter"
            return false

        }
        if (password.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) {
//            errorMsg += ", one number"
            return false

        }
        if password.count < 6 {
//            errorMsg += ", and eight characters"
            return false

        }
        return true
    }

    
    class func weekDay(date:Date, endStr:String?) -> String {
        let cal = Calendar(identifier: .gregorian)
        let comps = cal.dateComponents([.weekday], from: date)
        var str = ""
        if comps.weekday == 1 {
            str = "일"
        }
        if comps.weekday == 2 {
            str = "월"
        }
        if comps.weekday == 3 {
            str = "화"
        }
        if comps.weekday == 4 {
            str = "수"
        }
        if comps.weekday == 5 {
            str = "목"
        }
        if comps.weekday == 6 {
            str = "금"
        }
        if comps.weekday == 7 {
            str = "토"
        }
        
        if endStr != nil
        {
            return str + endStr!
        }else{
            return str
        }
        
    }
    
    // 별점 이미지
    class func starImgFromDouble(dv:Double) -> UIImage?{
        var img:UIImage?
        
//        var dv = 3.6
//        let grade = Int(exactly: dv)!
        
        if dv < 0.5 {
            img = UIImage.init(named: "icon_star_0")
        }else if dv < 1.5 {
            img = UIImage.init(named: "icon_star_1")
        }else if dv < 2.5 {
            img = UIImage.init(named: "icon_star_2")
        }else if dv < 3.5 {
            img = UIImage.init(named: "icon_star_3")
        }else if dv < 4.5 {
            img = UIImage.init(named: "icon_star_4")
        }else{
            img = UIImage.init(named: "icon_star_5")
        }
        return img
    }
    
    class func convertDateFormat(dateStr:String,beforeFmtStr:String, afterFmtStr:String) -> String{
        let fmt = DateFormatter()
        fmt.dateFormat = beforeFmtStr
        let tmpD = fmt.date(from: dateStr) as! Date
        fmt.dateFormat = afterFmtStr
        let dateStr = fmt.string(from: tmpD) as! String
        return dateStr
    }
    
    class func timeStrFromSec(time:NSNumber) -> String{
        let hour = time.intValue/3600
        var min = time.intValue/60
        var timeStr = ""
        if hour>0{
            min = (time.intValue - hour*3600)/60
            timeStr = String(format: "%i시간 %i분",hour, min)
        }else{
           timeStr = String(format: "%i분", min)
        }
        return timeStr
    }
    
    class func timeStrFromSec(time:Double) -> String{
        let timeNum = NSNumber.init(value: time)
        let hour = timeNum.intValue/3600
        var min = timeNum.intValue/60
        var timeStr = ""
        if hour>0{
            min = (timeNum.intValue - hour*3600)/60
            timeStr = String(format: "%i시간 %i분",hour, min)
        }else{
           timeStr = String(format: "%i분", min)
        }
        return timeStr
    }

    
    class func distanceStrFromMeter(meter:NSNumber) -> String {
        var distanceStr = ""
        if meter.intValue > 1000 {
            distanceStr = String(format: "%0.1f km", meter.doubleValue/1000)
        }else{
            distanceStr = String(format: "%0.1f m", meter.doubleValue)
        }
        return distanceStr
    }
    
    class func showFont(){
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    class func removeWhiteSpace(str:String) -> String {
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
//    class func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
//        if let cachedImage = APP.imageCache.object(forKey: url.absoluteString as NSString) {
//            completion(cachedImage, nil)
//        } else {
//            Utility.downloadData(url: url) { data, response, error in
//                if let error = error {
//                    completion(nil, error)
//
//                } else if let data = data, let image = UIImage(data: data) {
//                    APP.imageCache.setObject(image, forKey: url.absoluteString as NSString)
//                    completion(image, nil)
//                } else {
//                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
//                }
//            }
//        }
//    }
//
//    class func downloadImage(str: String, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
//        if let cachedImage = APP.imageCache.object(forKey:str as NSString) {
//            completion(cachedImage, nil)
//        } else {
//            Utility.downloadData(url: URL.init(string: str)!) { data, response, error in
//                if let error = error {
//                    completion(nil, error)
//
//                } else if let data = data, let image = UIImage(data: data) {
//                    APP.imageCache.setObject(image, forKey:str as NSString)
//                    completion(image, nil)
//                } else {
//                    completion(nil, NSError.generalParsingError(domain:str))
//                }
//            }
//        }
//    }

    fileprivate static func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    class func getLangCode() -> String{
        let localeID = Locale.preferredLanguages.first
        let deviceLocale = (Locale(identifier: localeID!).languageCode)!
        print(deviceLocale)
        return deviceLocale
    }
    
    class func getCurrencyCode() -> String{
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol!
        if let currencyCode = locale.currencyCode{
            print(currencyCode)
            return currencyCode
        }else{
            return "KRW"
        }
            
    }
    

    class func calTimeIntervalFromNow(fromDateStr:String) -> Double{
        let df = DateFormatter.init()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowDate:Date = Date.init()
        let firstTime = df.date(from: fromDateStr)
        let interval = firstTime?.timeIntervalSince(nowDate)
        print(interval!)
        return interval!
    }
    
    class func isOverOneDay(fromDateStr:String) -> Bool{
        let oneDay = 60.0*60*24
        if Utility.calTimeIntervalFromNow(fromDateStr: fromDateStr) < oneDay {
            return false
        }
        return true
    }
    
    class func imgUrlAdded(str:String) -> String{
        var urlStr = str
        if urlStr.hasPrefix("http"){
            return urlStr
        }else{
            if urlStr.hasPrefix("/"){
                urlStr = APP.IMAGE_HOST_URL + "/" + str
            }else{
                urlStr = APP.IMAGE_HOST_URL + str
            }
            return urlStr
        }
    }
    
    class func timeIntervalFromToString(beforeStr:String, afterString:String, dateFormate:String) -> TimeInterval{
        let nowGuivingDateStr = beforeStr
        let df = DateFormatter.init()
        df.dateFormat = dateFormate
        let nowGuivingDate = df.date(from: nowGuivingDateStr)
        let dueGuivingDateStr = afterString
        let dueGuivingDate = df.date(from: dueGuivingDateStr)
        if let interval = dueGuivingDate?.timeIntervalSince(nowGuivingDate!){
            return interval
        }
        return 0

    }
    
    class func loadImageAsync(stringURL: String, completion: @escaping (UIImage?, Error?) -> Void) {
           let url = URL(string: stringURL)!

           URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data, error == nil else {
                   DispatchQueue.main.async { completion(nil, error) }
                   return
               }
               let image = UIImage(data: data)
               DispatchQueue.main.async { completion(image, nil) }
           }.resume()
    }
    
    class func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = APP.imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            Utility.downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data, let image = UIImage(data: data) {
                    APP.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
                }
            }
        }
    }
    
    class func downloadImage(str: String, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = APP.imageCache.object(forKey:str as NSString) {
            completion(cachedImage, nil)
        } else {
            Utility.downloadData(url: URL.init(string: str)!) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let data = data, let image = UIImage(data: data) {
                    APP.imageCache.setObject(image, forKey:str as NSString)
                    completion(image, nil)
                } else {
                    completion(nil, NSError.generalParsingError(domain:str))
                }
            }
        }
    }


    
}
