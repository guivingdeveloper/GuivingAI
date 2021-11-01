//
//  BottomView.swift
//  GuivingUser
//
//  Created by JangHyun on 08/03/2019.
//  Copyright © 2019 hyun. All rights reserved.
//

import UIKit


protocol BottomViewDelegate {
    func selectHome()
    func selectRes()
    func selectMsg()
    func selectMore()
}

class BottomView: XibView {
    
    @IBOutlet weak var homeBdg: UIImageView!
    @IBOutlet weak var resBdg: UIImageView!
    
    
    @IBOutlet weak var homeIV: UIImageView!
    @IBOutlet weak var resIV: UIImageView!
    
    
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var resBtn: UIButton!
    @IBOutlet weak var msgBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        homeBdg.isHidden = true
        resBdg.isHidden = true

        btnClear()


    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        homeIV.isHidden = true
        resIV.isHidden = true
        
        
    }
    
    var delegate:BottomViewDelegate?
    
    func btnClear(){
        var i = APP.selectedTap
        if i == nil{
            i = 0
        }
        homeIV.image = UIImage.init(named: "btn_bottom_home")
        resIV.image = UIImage.init(named: "btn_bottom_more")
        
        
        
        if i == 0 {
            homeBtn.isEnabled = false
            homeIV.image = UIImage.init(named: "btn_bottom_home_sel")
        }else if i == 1{
            resBtn.isEnabled = false
            resIV.image = UIImage.init(named: "btn_bottom_more_sel")
        }
    }
    
    @IBAction func goHome(_ sender: Any) {
        delegate?.selectHome()
        APP.selectedTap = 0
    }
    
    @IBAction func goRes(_ sender: Any) {
        delegate?.selectRes()
        APP.selectedTap = 1
    }
    
    @IBAction func goMsg(_ sender: Any) {
        delegate?.selectMsg()
        APP.selectedTap = 2
    }
    @IBAction func goMore(_ sender: Any) {
        delegate?.selectMore()
        APP.selectedTap = 3
    }
}
