//
//  ViewController.swift
//  SwiftProgressHUD
//
//  Created by li.min on 16/9/2.
//  Copyright © 2016年 li.min. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SwiftProgressHUD.shareInstance.showIndicatorHUD()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

