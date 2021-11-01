//
//  XibView.swift
//  GuivingUser
//
//  Created by JangHyun on 08/03/2019.
//  Copyright © 2019 hyun. All rights reserved.
//

import UIKit

class XibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else { return }
        let view = Bundle.main.loadNibNamed(xibName, owner:self, options:nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
