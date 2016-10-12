//
//  BaseAlamofire.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/9/2.
//  Copyright © 2016年 li.min. All rights reserved.
//

import Foundation
import UIKit

enum HUDStatus:Int{
    case show = 0
    case remove
    
    func checkHUDStatus()->Bool{
        switch self {
        case .show://当前已有HUD在显示
            return false
        default://当前没有任何HUD在显示
            return true
        }
    }
}

enum HUDStyle:Int{
    
    case Indicator
    case Text
}
class SwiftProgressHUD{
    var isShow:HUDStatus = .remove
    var progressHUD:ProgressHUD?
    var indicatorHUD:IndicatorHUD?
    var hudStyle:HUDStyle = .Indicator
    static var shareInstance = SwiftProgressHUD()
    
    fileprivate init(){
        
    }
    
    func showHUD(){
        addHUD()
    }
    
    fileprivate func addHUD(){
        let radius:CGFloat = 40.0
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        progressHUD = ProgressHUD.init(frame: CGRect(x: (width - radius * 2)/2, y: (height - radius * 2)/2, width: 2 * radius, height: 2 * radius))
        let window = UIApplication.shared.windows.last
        window!.rootViewController?.view.addSubview(progressHUD!)
    }
    

    func showIndicatorHUD(){
        if isShow.checkHUDStatus() {
             addIndicatorHUD()
        }
       
    }

    
    fileprivate func addIndicatorHUD(){
        let radius:CGFloat = 40.0
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        indicatorHUD = IndicatorHUD.init(frame: CGRect(x: (width - radius * 2)/2, y: (height - radius * 2)/2, width: 2 * radius, height: 2 * radius))
        let window = UIApplication.shared.windows.last
        window!.rootViewController?.view.addSubview(indicatorHUD!)
    }
    
    func stopIndicatorHUD(){
        removeIndicatorHUD()
    }
    
    fileprivate func removeIndicatorHUD(){
        indicatorHUD?.removeFromSuperview()
    }
}
