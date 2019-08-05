//
//  BaseViewController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/8/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
    
    }

}


extension BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

