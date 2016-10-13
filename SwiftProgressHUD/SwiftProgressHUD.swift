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
    fileprivate var isShow:HUDStatus = .remove
    fileprivate var indicatorHUD:IndicatorHUD?
    fileprivate var textHUD:TextHUD?
    fileprivate var hudStyle:HUDStyle = .None
    fileprivate var textTimer:Timer?
    fileprivate let duration = 0.5
    static var shareInstance = SwiftProgressHUD()
    fileprivate init(){
        
    }

    //MARK: - 展示指示器
    func showIndicatorHUD(){
        if !isShow.checkHUDStatus() {
            self.addIndicatorHUD()
        }
    }
    
    //MARK: - 展示文字标签
    func showTextHUD(text:String){
        if !isShow.checkHUDStatus() {
            addTextHUD(text: text)
        }
    }
    
    //MARK: - 添加指示器
    fileprivate func addIndicatorHUD(){
        let radius:CGFloat = 40.0
        indicatorHUD = IndicatorHUD.init(frame: CGRect(x: (width - radius * 2)/2, y: (height - radius * 2)/2, width: 2 * radius, height: 2 * radius))
        let window = UIApplication.shared.windows.last
        window!.rootViewController?.view.addSubview(indicatorHUD!)
        hudStyle = .Indicator
        isShow = .show
    }
    
    //MARK: - 添加文字表情
    fileprivate func addTextHUD(text:String){
        
        //计算好文字的size
        let font = UIFont.systemFont(ofSize: 12)
        let constriantSize = CGSize.init(width: width, height: height)
        let textSize = text.textSizeWithFont(font: font, constrainedToSize: constriantSize)
        let textHUDSize = CGSize.init(width: textSize.width + 40, height: textSize.height + 30)
        
        //初始化textHUD
        self.textHUD = TextHUD.init(frame: CGRect(x:(width - textHUDSize.width)/2,y:(height - textHUDSize.height)/2,width:textHUDSize.width,height:textHUDSize.height))
        self.textHUD?.configure(text: text)
        
        //实现慢慢淡入效果
        UIView.animate(withDuration: duration) {
            self.textHUD?.alpha = 0.6
            let window = UIApplication.shared.windows.last
            window!.rootViewController?.view.addSubview(self.textHUD!)
            self.hudStyle = .Text
            self.isShow = .show
            self.textTimer = Timer.scheduledTimer(timeInterval: self.duration + 1, target: self, selector: #selector(SwiftProgressHUD.removeTextHUD), userInfo: nil, repeats: false)
        }
        
    }
    
    //MARK: - 移除HUD
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
                    self.textTimer?.invalidate()
                    self.textTimer = nil
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
