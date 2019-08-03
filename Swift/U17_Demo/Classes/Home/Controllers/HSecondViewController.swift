//
//  HSecondViewController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/8/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit
import MyFirstFramework
// import module
/**
 什么是module?
 framework、library等等
 */


class HSecondViewController: PageViewController {

    // MARK: - Access modifier 访问权限修饰符
    /**
     private: 修饰的属性和方法只能在本类中访问，包括extension。 继承到子类也不能访问。
     
     fileprivate: 修饰的属性和方法只能在当前的swift源文件中访问。其他和private一样。
     
     internal: 默认的访问权限，在整个module内是可访问的。在framework、library内部是可以访问的，在整个App内是可以访问的。
     
     public: 可以被任何人访问。但在其他module中不可以inherit和override。
     
     open: 可以被任何人使用，包括inherit和override。
     */
    
    private var desc: String = "☺️☺️"
    
    fileprivate var content: String = "🤩🤩"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(desc)
        
        let f = First.init()
        print(f.a(orders: [1,2,3,4,5,6,7,8,9]))
        print(f.b(orders: [1,2,3,4,5,6,7,8,9]))
//        print(f.c(orders: [1,2,3,4,5,6,7,8,9]))
    }

}


// 
class ABC: First {
    override func a(orders: Array<Any>) -> Array<Any> {
        print("override")
        return [1, 2, 3]
    }
}


class CustomController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ctrl = HSecondViewController.init()
//        ctrl.desc = "abc"
        ctrl.content = "哔哔"
    }
    
}
