//
//  Constants.swift
//  GuivingUser
//
//  Created by Nonghyup on 2018. 11. 7..
//  Copyright © 2018년 hyun. All rights reserved.
//

import Foundation

import UIKit

let IS_DEBUG_MODE = false

let IS_ONLY_EMAIL = true
let IS_ONLY_ONE_DAY = true
let IS_ONLY_DOMESTIC_CARD = true
let IS_REVIEW_HIDDEN = true

// 네이버 지도 Key (Dev)
let KEY_N_MAP_KEY_ID = "1mh31is8dl"
let KEY_N_MAP_KEY = "PRu88rpBlZc4UYi6cKW8JpzlK62wRyenKHGXVt2M"

// 관광정보 API Key (Dev)
let KEY_VISIT_KOREA_API = "KcfrvqcEch%2BcWbMVWzzGbymjPVF77i%2F4njDsul8qJ7Nws8npqwVk4%2FoVVwr0NfuyNnXYfMgyGYjEJnnVvvJluQ%3D%3D"


let CATE_CODE_ALL = "1"
let CATE_CODE_TOUR = "12"
let CATE_CODE_CULTURE = "14"
let CATE_CODE_FOOD = "39"
let CATE_CODE_REPORTS = "28"
let CATE_CODE_SHOPPING = "38"
let CATE_CODE_BOOKMARK = "100"

let CATE_ARRAY = [CATE_CODE_TOUR, CATE_CODE_CULTURE, CATE_CODE_FOOD, CATE_CODE_REPORTS, CATE_CODE_SHOPPING]
//let CATE_CODE_BOOK_MARK = "101"

// 경주
//let dummyLat = "35.85631070975238"
//let dummyLon = "129.224878100072"

// 강남
var dummyLat = "37.49697977522117"
var dummyLon = "127.03120331618723"


//let IS_DEBUG_MODE = false

//let HOST_URL:String = "http://13.209.198.22:8080/Guiving/"      // Staging SERVER
//let HOST_URL_:String = "http://13.209.198.22:8080/Guiving"      // Staging SERVER

//let HOST_URL:String = "http://13.209.198.22/"      // Staging SERVER
//let HOST_URL_:String = "http://13.209.198.22"      // Staging SERVER

//let HOST_URL:String = "http://112.187.234.6/"      // 포트포워딩
//let HOST_URL_:String = "http://112.187.234.6"      // 포트포워딩

//let HOST_URL:String = "http://13.124.207.108/"      // TEST SERVER
//let HOST_URL_:String = "http://13.124.207.108"      // TEST SERVER
//let HOST_URL:String =   "http://dev.guiving.com/"    // Guiving 5G
//let HOST_URL_:String =   "http://dev.guiving.com"    // Guiving 5G
//let HOST_URL:String =   "http://172.30.1.17/"    // Guiving 5G
//let HOST_URL_:String =   "http://172.30.1.17"    // Guiving 5G

//let HOST_URL:String =   "http://169.254.186.121/"    // Guiving 5G
//let HOST_URL_:String =   "http://169.254.186.121"    // Guiving 5G

//let HOST_URL:String =   "http://localhost/"       // Guiving 5G
//let HOST_URL:String =   "http://172.30.1.55/"     // Guiving 5G
//let HOST_URL_:String  =   "http://172.30.1.55"    // Guiving 5G
//let HOST_URL_:String =   "http://54.254.242.86"     // Guiving 5G
//let HOST_URL:String =   "http://54.254.242.86/"   // Guiving 5G
//let HOST_URL:String =   "http://localhost/"       // Guiving 5G
//let HOST_URL_:String =   "http://localhost"       // Guiving 5G

//let HOST_URL:String =   "http://192.168.1.8/"       // Guiving 5G
//let HOST_URL_:String =   "http://192.168.1.8"       // Guiving 5G
//
//let HOST_URL:String =   "http://192.168.1.21/"       // Guiving 5G
//let HOST_URL_:String =   "http://192.168.1.21"       // Guiving 5G

let HOST_URL:String =   "http://172.20.10.3/"       // Guiving 5G
let HOST_URL_:String =   "http://172.20.10.3"       // Guiving 5G


//let HOST_URL:String =   "http://121.135.149.107:88/"       // 사무실 포트포워딩
//let HOST_URL_:String =   "http://121.135.149.107:88"       // 사무실 포트포워딩

//let HOST_URL:String =   "http://192.168.0.2/"       // 자택
//let HOST_URL_:String =   "http://192.168.0.2"       // 자택

//let HOST_URL:String =   "http://192.168.225.36:8080/Guiving/"       // Guiving 5G
//let HOST_URL_:String =   "http://192.168.225.36:8080/Guiving"       // Guiving 5G

//http://18.139.5.76

//let wsURL = "ws://121.135.149.107:80/websocket"
let wsURL = "ws://192.168.1.21/websocket"
//let wsURL = "ws://169.254.186.121/websocket"
//let wsURL = "ws://172.30.1.17/websocket"
//let wsURL = "ws://dev.guiving.com/websocket"
//let wsURL = "ws://192.168.225.36:8080/Guiving/websocket"
let NC = NotificationCenter.default
let APP = AppDelegate.sharedInstance()


let NOTI_RESIGN_ACTIVE =                     "noti_resign_antive"

let NOTI_GOTO_REG =                     "noti_goto_reg"
let NOTI_GOTO_D_MAIN_FROM_CALLING =     "noti_goto_d_main_from_calling"
let NOTI_GOTO_GUIVING_DONE =            "noti_goto_guiving_done"
let NOTI_GOTO_AIRPICK_DONE =            "noti_goto_air_done"
let NOTI_GOTO_NEXT_GUIVING_PICK =            "noti_goto_next_guiving_pick"
let NOTI_GOTO_DRIVING =                 "noti_goto_driving"

//let NOTI_GOTO_SET_THIS_PICK_UP =                 "noti_goto_set_this_pick_up"

let NOTI_GOTO_SELECT_SERVICE =            "noti_goto_select_service"

let NOTI_GOTO_COMING =                 "noti_goto_coming"

let NOTI_GOTO_CALLING =                 "noti_goto_caliing"

let NOTI_GOTO_CHANGE_FIRST_DEST =                 "noti_goto_change_first_dest"

let NOTI_GOTO_SET_THIS_PICKUP =                 "noti_goto_set_this_pickup"
let NOTI_GOTO_RES_DETAIL =                 "noti_goto_res_detail"

let NOTI_GOTO_SELECT_AIRPICK =            "noti_goto_select_airpick"
let NOTI_GOTO_SELECT_GUIVING =            "noti_goto_select_guiving"

let NOTI_AFTER_ADD_CARD =            "noti_after_add_card"

let NOTI_RECEIVE_SOCKET_DATA =            "noti_receive_socket_data"

let NOTI_SOCKET_CONNECTED =            "noti_socket_connected"


let DEFAULT_SNS_TYPE =  "default_sns_type"
let DEFAULT_UID =        "default_uid"
let DEFAULT_LANG =        "default_lang"
let DEFAULT_CURRENCY =        "default_currency"
let DEFAULT_UNIT =        "default_unit"

let DEFAULT_SEARCH_HIST = "default_search_hist"

let DEFAULT_CURRENCY_FLAG = "default_currency_flag"

let DEFAULT_BOOKMARK_FULL = "default_bookmark_full"
let DEFAULT_BOOKMARK_LIST = "default_bookmark_list"

let DEFAULT_APPLE_ID = "default_apple_id"

let MainSB = UIStoryboard(name: "Main", bundle: nil)
let UserSB = UIStoryboard(name: "User", bundle: nil)
//let BookSB = UIStoryboard(name: "Book", bundle: nil)
//let DrivingSB = UIStoryboard(name: "Driving", bundle: nil)
//let ReservationSB = UIStoryboard(name: "Reservation", bundle: nil)
//let ChatSB = UIStoryboard(name: "Chat", bundle: nil)
//let ReviewSB = UIStoryboard(name: "Review", bundle: nil)
//let MoreSB = UIStoryboard(name: "More", bundle: nil)
//AIzaSyAtn3mFPJUnGYjrZrR6ZJhYUAEaNgcexpQ
// Google Directions API KEY
let GOOGLE_DIRECTIONS_API_KEY = "AIzaSyAo_9Y6dsbDdbL-lmPczxm0wqgqFy_M5fY"
let GOOGLE_GMSSERVICE_API_KEY = "AIzaSyCqFSowmNKnhcg3XoAZeat4oNFwswoHZVo"
let GOOGLE_GMSPLACE_API_KEY = "AIzaSyBXBncEtO0tyCcoStqFtwWxX9TLfv45BGM"

let POLYLINE_STROKE_COLOR = UICOLOR_FROM_RGB(r:78,g:169,b:239)
let POLYLINE_LINE_WIDTH:CGFloat = 5

let DRAW_POLY_DELAY = 3

func UICOLOR_FROM_RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

func BUNDLE_OBJECT_FOR_KEY(key:String) -> Any?{
    return UserDefaults.standard.object(forKey: key)
}

func BUNDLE_SET_OBJECT_FOR_KEY(id:Any, key:String){
    UserDefaults.standard.set(id, forKey: key)
}

func BUNDLE_REMOVE_OBJECT_FOR_KEY(key:String){
    UserDefaults.standard.removeObject(forKey: key)
}

func NC_ADD(ID:Any, SEL:Selector, NAME:String) -> Void {
    NC.addObserver(ID, selector: SEL, name: NSNotification.Name(rawValue: NAME), object: nil)
}

func NC_ADD_OBJECT(ID:Any, SEL:Selector, NAME:String, OBJECT:Any?) -> Void {
    NC.addObserver(ID, selector: SEL, name: NSNotification.Name(rawValue: NAME), object: OBJECT)
}

func NC_REMOVE(ID:Any, NAME:String) -> Void {
    NC.removeObserver(ID, name: NSNotification.Name(rawValue: NAME), object: nil)
}

func NC_POST(ID:Any, NAME:String, OBJECT:Any?) -> Void {
    NC.post(name: NSNotification.Name(rawValue: NAME), object: OBJECT)
}

func NC_POST(ID:Any, NAME:String, OBJECT:Any?, userInfo:[AnyHashable : Any]?) -> Void {
    NC.post(name: NSNotification.Name(rawValue: NAME), object: nil, userInfo: userInfo)
}
