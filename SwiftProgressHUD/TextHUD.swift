//
//  TextHUD.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/10/12.
//  Copyright © 2016年 li.min. All rights reserved.
//

import UIKit

class TextHUD: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var textLabel:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text:String){
        textLabel = UILabel.init(frame: bounds)
        textLabel?.textColor = UIColor.white
        textLabel?.text = text
        textLabel?.textAlignment = .center
        backgroundColor = UIColor.black
        alpha = 0.0
        layer.masksToBounds = true
        layer.cornerRadius = 8
        addSubview(textLabel!)
    }
    
    
}
