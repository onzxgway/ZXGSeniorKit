//
//  ExtensionController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class ExtensionController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Extensions 给已有类型增加新的功能
/*
 定义：
    向已有的类、结构体、枚举或者协议类型添加新功能。(包括未开源的类型，例如UIView等等)
 
 与OC中的category(分类)类似，但是功能更加强大。
    区别：* category有名称，Swift的extension没有名称。
 
 功能：
     1.可以把代码进行模块化区分，把功能性相同的代码放到一个扩展中。这样代码层次就非常的清晰明了。
     2.添加计算实例属性和计算类型属性。
     3.定义实例方法和类型方法。
     4.提供新的构造方法。
     5.定义下标。
     6.定义并使用新的嵌套类型。
     7.使现有类型遵守协议。
 
 注意：
     * 扩展可以向类型添加新功能，但不能覆盖现有功能。
     * 如果您定义了一个扩展来向现有类型添加新功能，那么该新功能将在该类型的所有现有实例上可用，即使它们是在定义扩展之前创建的。
     * 扩展可以添加新的计算属性，但不能添加存储的属性，也不能向已有属性添加属性观察器。
     *
 */


// 2.添加计算实例属性
extension Double {
    
    internal var cm: Double {
        get {
            return self / 100.0
        }
    }
    internal var mm: Double {
        return self / 1_000.0  // 数值字面量可以增加额外的0和_来增强可读性
    }
    
}


// 5.定义下标。
extension ExtensionController {
    subscript(index: Int) -> String {
        set(newValue) {
            
        }
        
        get {
            return "88"
        }
    }
}
