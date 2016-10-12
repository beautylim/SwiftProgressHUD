//
//  ProgressHUD.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/9/2.
//  Copyright © 2016年 li.min. All rights reserved.
//

import UIKit

class ProgressHUD: UIView {
    
    var timer:Timer?
    let circlePathLayer = CAShapeLayer()
    var textLabel:UILabel?
    let circleRadius:CGFloat = 20.0
    var strokeEnd:CGFloat{
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if newValue > 1 {
                circlePathLayer.strokeEnd = 1
            } else if newValue < 0{
                circlePathLayer.strokeEnd = 0
            }else {
                circlePathLayer.strokeEnd = newValue
            }
            
        }
    }
    var strokeStart:CGFloat {
        get {
            return circlePathLayer.strokeStart
        }
        set {
            if newValue > 1 {
                circlePathLayer.strokeStart = 1
            } else if newValue < 0{
                circlePathLayer.strokeStart = 0
            }else {
                circlePathLayer.strokeStart = newValue
            }
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure(){
        strokeEnd = 0
        self.textLabel = UILabel.init(frame:CGRect(x: -bounds.size.width/2,y: -bounds.size.height/2, width: bounds.size.width, height: 15))
        self.textLabel?.text = "正在加载中"
        self.textLabel?.font = UIFont.systemFont(ofSize: 10)
        self.textLabel?.textColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 3
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(circlePathLayer)
        self.addSubview(textLabel!)
        backgroundColor = UIColor.black
        alpha = 0.5
        show()
        let transform = CGAffineTransform.identity
        self.transform = transform.rotated(by: CGFloat(-M_PI/2))
        self.textLabel?.transform = transform.rotated(by: CGFloat(M_PI/2))
    }
    
    func show(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ProgressHUD.run), userInfo: nil, repeats: true)
        
    }

    func run(){
        if self.strokeEnd == 1 {
            self.strokeStart = self.strokeStart + 0.1
            if self.strokeStart == 1 {
                self.strokeEnd = 0
            }
        }else if self.strokeStart == 1{
            self.strokeStart = 0
            self.strokeEnd = 0
        }else {
            self.strokeEnd = self.strokeEnd + 0.1
        }
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    
    func circleFrame() -> CGRect{
        var circleFrame = CGRect(x: 0,y: 0,width: 2 * circleRadius, height:2*circleRadius)
        circleFrame.origin.x = circlePathLayer.bounds.midX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.midY - circleFrame.midY
        return circleFrame
    }
    
    func circlePath()->UIBezierPath{
        return UIBezierPath.init(ovalIn: circleFrame())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    
}
