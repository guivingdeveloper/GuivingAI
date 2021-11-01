//
//  BaseViewController.swift
//  GuivingAI
//
//  Created by JangHyun on 2021/08/03.
//

import UIKit
class BaseViewController: UIViewController, BottomViewDelegate{
    func selectMsg() {
        
    }
    
    func selectMore() {
        
    }
    
    var tapView: BottomView!

    @IBOutlet weak var bottom: NSLayoutConstraint?

    @IBAction func goBack(_ sender: Any?) {
        if navigationController != nil {
            navigationController?.popViewController(animated: false)
        } else {
            dismiss(animated: false)
        }
    }
    
    @IBAction func keyDown(_ sender: Any?) {
        self.view.endEditing(true)
        if bottom != nil {
            bottom!.constant = 0
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NC_REMOVE(ID: self, NAME: NOTI_GOTO_SELECT_SERVICE)
//        NotificationCenter.default.removeObserver(self)
        keyDown(nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NC_ADD(ID: self, SEL:#selector(resignActive), NAME:NOTI_GOTO_SELECT_SERVICE)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APP.nowVC = self
        // 하단 tap menu
        let window = UIApplication.shared.keyWindow!
        let viewWidth = window.frame.size.width
        let viewHeight = window.frame.size.height - window.safeAreaInsets.bottom
        let viewFrame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        
        let bottomHeight: CGFloat = 52
        tapView = BottomView(frame: CGRect(x: 0, y: viewFrame.size.height - bottomHeight, width: view.frame.size.width, height: CGFloat(bottomHeight)))
        tapView.delegate = self
        view.addSubview(tapView!)
        tapView.isHidden = false

    }
    
    @objc func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //            if self.view.frame.origin.y == partialView {
            let offset: CGSize = ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
            let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double)
            print(offset.height)
            var safeAreaBottomInset:CGFloat = 0.0;
            if #available(iOS 11.0, *) {
                safeAreaBottomInset = self.view.safeAreaInsets.bottom
            }

            if keyboardSize.height == offset.height {
                if self.bottom != nil {
                    self.bottom!.constant = -(keyboardSize.height-safeAreaBottomInset)
                    self.view.setNeedsUpdateConstraints()
                    //                    [self.view setNeedsUpdateConstraints];
                    
                    UIView.animate(withDuration: keyboardDuration!) {
                        self.view.layoutIfNeeded()
                        //                        [self.view layoutIfNeeded];
                        
                        //                        if self.nextBtn.frame.origin.y != -keyboardSize.height{
                        //                            self.nextBtn.frame.origin.y = originY-keyboardSize.height
                        //
                        //                        }
                    }
                    //                    UIView.animate(withDuration: keyboardDuration!, animations: { () -> Void in
                    //                        self.bottom.constant = -keyboardSize.height
                    ////                        self.view.frame.origin.y -= keyboardSize.height
                    //                    })
                }
                
            } else {
                //                    UIView.animate(withDuration: keyboardDuration!, animations: { () -> Void in
                //                        self.bottom.constant = 0
                ////                        self.view.frame.origin.y += keyboardSize.height - offset.height
                //                    })
            }
            //            }
        }
    }

    func selectHome() {
        let vc:ViewController = MainSB.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        APP.nav.pushViewController(vc, animated: false)
    }
    
    func selectRes() {
        let vc:InfoViewController = MainSB.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        APP.nav.pushViewController(vc, animated:false)
    }
    
//    func selectMsg() {
//        let vc:ChatListViewController =  ChatSB.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
//        APP.nav.pushViewController(vc, animated:false)
//    }
//
//    func selectMore() {
//        let vc:MoreViewController = MoreSB.instantiateViewController(withIdentifier: "MoreViewController") as! MoreViewController
//        APP.nav.pushViewController(vc, animated: false)
//    }
    
    func showTap(_ yn: Bool) {
        if yn {
            view.bringSubviewToFront(tapView)
            tapView.isHidden = false
        } else {
            tapView.isHidden = true
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

    
    @objc func resignActive(notification: Notification) {
        self.viewWillAppear(false)
        self.viewDidAppear(false)
    }

}
