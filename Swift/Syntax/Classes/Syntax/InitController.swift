//
//  InitController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/9.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    构造过程：
        使用类、结构体或枚举类型实例之前的准备过程。在新实例使用之前这个过程是必须的，它包括设置实例中每个存储属性的初始值 和 执行其它必须的设置或构造过程。
 
    如果实现构造过程：
            通过定义构造器来实现构造过程。
    构造器：
            创建类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器没有返回值。
 */

/*
    存储属性的初始赋值
 
        类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
        赋值时机：
            1.可以在构造器中为存储型属性设置初始值。
            2.也可以在定义存储型属性的时候分配默认值。
        注意：
        当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。
 */
class InitController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
