//
//  HServer.swift
//  GuivingUser
//
//  Created by JangHyun on 12/02/2019.
//  Copyright © 2019 hyun. All rights reserved.
//

import Alamofire
import Foundation

class HServer{
    
    static func reqVisit(urlStr:String, completion:@escaping(Bool, Any?) -> Void){
          LoadingIndicator.shared.show()
          
          Alamofire.request(urlStr,
                            method: HTTPMethod.get,
                            parameters: nil,
                            encoding: URLEncoding.default,
                            headers: nil)
              .responseJSON { (response) in
//                  LoadingIndicator.shared.hide()

                  DispatchQueue.main.async {

                      if let JSON = response.result.value as? NSDictionary {
                          print(urlStr)
                          print(JSON)
                        if let response = JSON["response"] as? [String:Any], let header = response["header"] as? [String:Any], let resCode = header["resultCode"] as? String, resCode == "0000"{
                            if let body = response["body"] as? [String:Any], let items = body["items"] as? [String:Any], let item = items["item"] as? [[String:Any]]{
                              completion(true, item)
                            }else{
                              completion(false, nil)
                            }
                          }else{
                              completion(false, nil)
                          }
                      }else{
                          completion(false, nil)
                      }
                  }
          }
    }
    
    static func reqVisitDetail(urlStr:String, completion:@escaping(Bool, Any?) -> Void){
          LoadingIndicator.shared.show()
          
          Alamofire.request(urlStr,
                            method: HTTPMethod.get,
                            parameters: nil,
                            encoding: URLEncoding.default,
                            headers: nil)
              .responseJSON { (response) in
                  LoadingIndicator.shared.hide()

                  DispatchQueue.main.async {
                      
                      if let JSON = response.result.value as? NSDictionary {
                          print(urlStr)
                          print(JSON)
                        if let response = JSON["response"] as? [String:Any], let header = response["header"] as? [String:Any], let resCode = header["resultCode"] as? String, resCode == "0000"{
                            if let body = response["body"] as? [String:Any], let items = body["items"] as? [String:Any], let item = items["item"] as? [String:Any]{
                              completion(true, item)
                            }else{
                              completion(false, nil)
                            }
                          }else{
                              completion(false, nil)
                          }
                      }else{
                          completion(false, nil)
                      }
                  }
          }
    }
    
    
//
    static func reqGET(urlStr:String, completion:@escaping(Bool, Any?) -> Void){
//        LoadingIndicator.shared.show()

        Alamofire.request(urlStr,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: URLEncoding.default)
            .responseJSON { (response) in
//                LoadingIndicator.shared.hide()

                DispatchQueue.main.async {

                    if let JSON = response.result.value as? NSDictionary {
                        print(urlStr)
                        print(JSON)
                        if let resCode = JSON["result_code"], resCode as! Int == 200{
                            completion(true, JSON["result"])
                        }else{
                            completion(false, nil)
                        }
                    }else{
                        completion(false, nil)
                    }
                }
        }
    }
//
//    static func reqPOST(urlStr:String, paramDic:[String:Any], completion:@escaping(Bool, Any?) -> Void){
//        LoadingIndicator.shared.show()
//        Alamofire.request(urlStr,
//                          method: HTTPMethod.post,
//                          parameters: paramDic,
//                          encoding: JSONEncoding.default,
//            .responseJSON { (response) in
//                LoadingIndicator.shared.hide()
//                DispatchQueue.main.async {
//                    if let JSON = response.result.value as? NSDictionary {
//                        print(urlStr)
//                        print(JSON)
//                        if let resCode = JSON["result_code"], resCode as! Int == 200{
//                            completion(true, JSON["result"])
//                        }else{
//                            completion(false, nil)
//                        }
//                    }else{
//                        completion(false, nil)
//                    }
//                }
//        }
//    }
//
//    static func reqPOSTtmp(urlStr:String, paramDic:[String:Any], completion:@escaping( String?) -> Void){
//        LoadingIndicator.shared.show()
//
//        Alamofire.request(urlStr,
//                          method: HTTPMethod.post,
//                          parameters: paramDic,
//                          encoding: JSONEncoding.default)
//            .responseJSON { (response) in
//                LoadingIndicator.shared.hide()
//                DispatchQueue.main.async {
//                    if let JSON = response.result.value as? NSDictionary {
//                        print(JSON)
//                        if let result = JSON["result"] as? [String:Any]{
//                            if let resCode = result["mobile_url"] as? String{
//                                completion(resCode)
//                            }
//                        }
//                    }
//                }
//        }
//    }
//
    static func reqNMap(urlStr:String, completion:@escaping(Bool, Any?) -> Void){
        LoadingIndicator.shared.show()

        Alamofire.request(urlStr,
                          method: HTTPMethod.get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: ["X-NCP-APIGW-API-KEY-ID":KEY_N_MAP_KEY_ID, "X-NCP-APIGW-API-KEY":KEY_N_MAP_KEY])
            .responseJSON { (response) in
                LoadingIndicator.shared.hide()

                DispatchQueue.main.async {

                    if let JSON = response.result.value as? NSDictionary {
                        print(urlStr)
                        print(JSON)
                        if let resCode = JSON["code"], resCode as! Int == 0{
                            if let route = JSON["route"] as? [String:Any] {
                                if let traoptimal = route["traoptimal"] as? [Any] {
                                    if let traoptimalDic = traoptimal[0] as? [String:Any] ,let path = traoptimalDic["path"] as? [Any]{
                                        completion(true, traoptimalDic)
                                    }
                                }
                            }

                        }else{
                            completion(false, nil)
                        }
                    }else{
                        completion(false, nil)
                    }
                }
        }
    }
//
//
//
//    static func reqMultiPart(urlStr:String, paramDic:[String:Any], image:UIImage?, imageNameStr:String?, completion:@escaping(Bool, Any?) -> Void){
//        LoadingIndicator.shared.show()
//
//        Alamofire.upload(multipartFormData: { (form) in
//            if let _ :UIImage = image {
//
//                //                form.append(image!.pngData()!, withName: "userImage", fileName: "userImageName.png", mimeType: "image/png")
//                form.append(image!.jpegData(compressionQuality: 0.1)!, withName:imageNameStr!, fileName: "fileName.png", mimeType: "image/png")
//            }
//
//            for (key, value) in paramDic {
//                form.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//
//        }, usingThreshold: 1000,
//           to: urlStr,
//           method: .post,
//           headers: ["USER_EXC_SYMBOL":excSymbol, "Authorization":authToken],
//           encodingCompletion: { (result) in
//            LoadingIndicator.shared.hide()
//            switch result {
//            case .success(let upload, _, _):
//                //                upload.responseJSON(completionHandler: <#T##(DataResponse<Any>) -> Void#>)
//                upload.responseJSON { response in
//
//                    if let JSON = response.result.value as? NSDictionary {
//                        print(urlStr)
//                        print(JSON)
//                        if let resCode = JSON["result_code"], resCode as! Int == 200{
//                            completion(true, JSON["result"])
//                        }
//                    }
//
//                    //                    print(response.value as Any)
//                    //                    completion(true)
//
//                }
//            case .failure(let encodingError):
//                completion(false, nil)
//                print(encodingError)
//            }
//        })
//
//    }
}
