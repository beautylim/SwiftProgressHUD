//
//  IndicatorHUD.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/9/5.
//  Copyright © 2016年 li.min. All rights reserved.
//

import UIKit

class IndicatorHUD: UIView {

    var indicator:UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    deinit {
        print("indicatorHUD deinit")
    }
    
    func configure(){
        backgroundColor = UIColor.black
        alpha = 0.6
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        indicator = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0,width: 80, height: 80))
        let transform = CGAffineTransform.identity
        indicator?.transform = transform.scaledBy(x: 2, y: 2)
        addSubview(indicator!)
        indicator?.startAnimating()
    }

}
