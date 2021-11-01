//
//  AppDelegate.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/07/28.
//

import UIKit
import NMapsMap

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav: UINavigationController = UINavigationController()
    var mainVC:ViewController?
    var userInfo:NSDictionary?
//    var mainVC:MainViewController?
    var nowVC:UIViewController?

    var IMAGE_HOST_URL:String!

    
//    var HOST_URL:String =   "http://10.10.0.39/"    // Guiving 5G
//    var HOST_URL_:String =   "http://10.10.0.39"    // Guiving 5G
    var HOST_URL:String =   "http://3.1.85.125:8080/"    // Guiving 5G
    var HOST_URL_:String =   "http://3.1.85.125:8080"    // Guiving 5G
    
    var selectedTap:Int?            // Tap bar 관리

    let imageCache = NSCache<NSString, UIImage>()
    static func sharedInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NMFAuthManager.shared().clientId = KEY_N_MAP_KEY_ID

        initCon()   // window, navCon, rootVC 초기화

        return true
    }
    
    func initCon(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"IntroViewController");
        self.nav = UINavigationController.init(rootViewController: vc)
        self.nav.setNavigationBarHidden(true, animated: false)
        self.nav.modalPresentationStyle = .fullScreen
        self.window?.rootViewController = self.nav
        self.window?.makeKeyAndVisible()
    }
}

