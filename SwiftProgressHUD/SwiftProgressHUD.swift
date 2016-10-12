//
//  BaseAlamofire.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/9/2.
//  Copyright © 2016年 li.min. All rights reserved.
//

import Foundation
import UIKit
let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height
enum HUDStatus:Int{
    case show = 0
    case remove
    
    func checkHUDStatus()->Bool{
        switch self {
        case .show://当前已有HUD在显示
            return true
        default://当前没有任何HUD在显示
            return false
        }
    }
}

enum HUDStyle:Int{
    
    case Indicator
    case Text
    case None
}
class SwiftProgressHUD{
    var isShow:HUDStatus = .remove
    var progressHUD:ProgressHUD?
    var indicatorHUD:IndicatorHUD?
    var textHUD:TextHUD?
    var hudStyle:HUDStyle = .None
    var textTimer:Timer?
    static var shareInstance = SwiftProgressHUD()
    let duration = 0.5
    
    fileprivate init(){
        
    }

    func showIndicatorHUD(){
        if !isShow.checkHUDStatus() {
            self.addIndicatorHUD()
        }
    }
    
    func showTextHUD(text:String){
        if !isShow.checkHUDStatus() {
            addTextHUD(text: text)
        }
    }
    
    fileprivate func addIndicatorHUD(){
        let radius:CGFloat = 40.0
        indicatorHUD = IndicatorHUD.init(frame: CGRect(x: (width - radius * 2)/2, y: (height - radius * 2)/2, width: 2 * radius, height: 2 * radius))
        let window = UIApplication.shared.windows.last
        window!.rootViewController?.view.addSubview(indicatorHUD!)
        hudStyle = .Indicator
        isShow = .show
    }
    
    fileprivate func addTextHUD(text:String){
        let font = UIFont.systemFont(ofSize: 12)
        let constriantSize = CGSize.init(width: width, height: height)
        let textSize = text.textSizeWithFont(font: font, constrainedToSize: constriantSize)
        let textHUDSize = CGSize.init(width: textSize.width + 40, height: textSize.height + 30)
        self.textHUD = TextHUD.init(frame: CGRect(x:(width - textHUDSize.width)/2,y:(height - textHUDSize.height)/2,width:textHUDSize.width,height:textHUDSize.height))
        self.textHUD?.configure(text: text)
        UIView.animate(withDuration: duration) {
            self.textHUD?.alpha = 0.6
            let window = UIApplication.shared.windows.last
            window!.rootViewController?.view.addSubview(self.textHUD!)
            self.hudStyle = .Text
            self.isShow = .show
               self.textTimer = Timer.scheduledTimer(timeInterval: self.duration + 1, target: self, selector: #selector(SwiftProgressHUD.removeTextHUD), userInfo: nil, repeats: false)
        }
        
    }
    
    func remove(){
        if isShow.checkHUDStatus() {
            switch self.hudStyle {
            case .Indicator:
                self.removeIndicatorHUD()
            case .Text:
                self.removeTextHUD()
            default:
                print("没有可remove的")
            }
        }
    }
    
    fileprivate func removeIndicatorHUD(){
        if indicatorHUD != nil {
            self.indicatorHUD?.removeFromSuperview()
            self.indicatorHUD = nil
            removeStatus()
            
        }
    }
    
    @objc fileprivate func removeTextHUD(){
            if self.textHUD != nil {
                UIView.animate(withDuration: duration, animations: { 
                    self.textHUD?.alpha = 0.0
                    }, completion: { (isFinish) in
                        self.textHUD?.removeFromSuperview()
                        self.textHUD = nil
                        self.removeStatus()
                })
                
            }
    }
    
    fileprivate func removeStatus(){
        self.hudStyle = .None
        self.isShow = .remove
    }
}
