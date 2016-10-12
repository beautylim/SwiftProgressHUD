//
//  SwiftExtension.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/10/12.
//  Copyright © 2016年 li.min. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        
        var textSize:CGSize!
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes:[String:AnyObject] = [NSFontAttributeName:font]
        let stringRect = self.boundingRect(with: size, options: option, attributes: attributes , context: nil)
        textSize = stringRect.size
        return textSize
        
    }
}
    
