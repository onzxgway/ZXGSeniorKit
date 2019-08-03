//
//  HomeViewController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/8/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class HomeViewController: PageViewController {

    // MARK: - lazy load
    /**
     优点：减少内存压力。用到的时候再加载到内存中。
     缺点：懒加载的属性，不能手动赋值nil释放。（OC可以）
     懒加载注意点：
        1.懒加载的属性，必须是变量var修饰，原因是：
            声明（定义）变量的时候，并没有赋值，真正的赋值是在初始化之后的某个时刻，如果是常量let的话,正在赋值的时刻会失败。
        2. 采用 {方法体}() 方式给属性赋值，相当于匿名方法。声明的时候，并不执行方法，之后首次用到的时刻再执行。
     */
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect.init(x: 100, y: 120, width: 88, height: 32)
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)
        print("加不加lazy,当前匿名函数永远都只执行一遍！")
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("============")
        view.addSubview(btn)
        view.addSubview(btn)
        view.addSubview(btn)
    }
    
    // MARK: - Action
    @objc func clicked() {
        let ctrl = HSecondViewController.init()
//        ctrl.content = "dudu"
        navigationController?.pushViewController(ctrl, animated: true)
    }

}
