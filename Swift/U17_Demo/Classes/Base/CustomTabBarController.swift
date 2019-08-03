//
//  CustomTabBarController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/7/28.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        /// 首页
        // 在对变量首次赋值的时候，会进行类型推断，之后该变量的类型保持不变。
        let home = HomeViewController.init()
        addChildViewController(home,
                               title: nil,
                               image: nil,
                               selectedImage: nil)
        
        /// 分类
        let category = UIViewController()
        category.view.backgroundColor = UIColor.gray
        addChildViewController(category,
                               title: nil,
                               image: nil,
                               selectedImage: nil)
        
        /// 书架
        let bookrack = UIViewController()
        bookrack.view.backgroundColor = UIColor.yellow
        addChildViewController(bookrack,
                               title: nil,
                               image: nil,
                               selectedImage: nil)
        
        /// 我的
        let mine = UIViewController()
        mine.view.backgroundColor = UIColor.blue
        addChildViewController(mine,
                               title: nil,
                               image: nil,
                               selectedImage: nil)
        
    }

    /**
     1.func addController(childCtrl:UIViewController)
        形参名会作为方法名称的组成部分。
        名称为 addController(childCtrl:)
     2.func addController(childController childCtrl:UIViewController)
        名称为 addController(childController:)
     3.func addController(_ childCtrl:UIViewController)
        名称为 addController()
     系统api使用2、3居多。
     */
    
    // 在方法申明的时候，形参必须显式的指定类型。
    func addChildViewController(_ childViewController:UIViewController, title:String?, image:UIImage?, selectedImage:UIImage?) -> Void {
        
        childViewController.title = title
        addChild(UINavigationController(rootViewController: childViewController))
        
    }

}
