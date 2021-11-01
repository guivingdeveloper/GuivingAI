//
//  ViewController.swift
//  GuivingUser
//
//  Created by Nonghyup on 2018. 10. 31..
//  Copyright © 2018년 hyun. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

let notification_go_to_main = "NOTIFICATION_GO_TO_MAIN" 
class IntroViewController: UIViewController{
        
    func mainProcess(){
        
        NC_ADD(ID: self, SEL:#selector(goToMain) , NAME: notification_go_to_main)
        
        if let uId = BUNDLE_OBJECT_FOR_KEY(key:DEFAULT_UID) as? String
        {
            
        }
        else
        {
            self.goToLoginMain()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToMain()
    }
    
    @objc func goToMain(){
        
        let vc = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier:"RegGenderViewController") as! RegGenderViewController
//        APP.nav.pushViewController(vc, animated: false);
        
        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ViewController") as! ViewController
//        APP.mainVC = vc as? ViewController
//        vc.isFirstLoad = true
        APP.nav.pushViewController(vc, animated: false);

    }
    
    func goToLoginMain(){
//        let vc = UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier:"LoginMainViewController") as! LoginMainViewController;
//        APP.nav.pushViewController(vc, animated: false);
    }
    
}

