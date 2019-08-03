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


// MARK: - extension
/**
    OC中有category(分类)和extension(扩展)的概念。
    Swift中只有extension(扩展)的概念，且功能十分强大。
 1.可以把代码进行模块化区分，把功能性相同的代码放到一个扩展中。这样控制器中的代码层次就非常的清晰明了。
 2.扩展可以向类型添加新功能，但不能覆盖现有功能。
    注意：如果定义扩展向现有类型添加新功能，那么该新功能将在该类型的所有现有实例上可用，即使它们是在定义扩展之前创建的。
 
 使用注意事项：
    * extension中不能包含存储属性。
 */
extension BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
