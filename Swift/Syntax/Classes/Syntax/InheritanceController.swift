//
//  InheritanceController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/20.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
 
    继承
        1.定义一个基类
        2.子类生成
        3.重写
        4.防止重写
 */


// 1.定义一个基类
/*
    不继承于任何类的类称为基类。
        注意：Swift中的类并不是从一个通用的基类继承而来的。如果你不为自己定义的类指定一个超类的话，这个类就会自动成为基类。
 */
class InVehicle {
    var currentSpeed = 0.0
    
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() -> Void {
        
    }
}


// 2.子类生成
class InBicycle: InVehicle {
    var hasBasket = false
}

class Tandem: InBicycle {
    var currentNumberOfPassengers = 0
}


// 3.重写
class Train: InVehicle {
    override func makeNoise() {
        
    }
}


// 4.防止重写
/*
 
    只需要在方法、属性、下标 声明关键字前加上 final 修饰符即可。（可被继承，不能被重写）
 
 
    可以通过在关键字 class 前添加 final 修饰符（final class）来将整个类标记为 final 。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
 */
class OVehicle {
    final var speed: Double {
        return 88.0
    }
    
    func makeNosie() {
        
    }
    
}

class OBus: OVehicle {
    // final修饰的 可以被继承，但是不能重写
//    override var speed: Double {
//        return 188
//    }
    
    override func makeNosie() {
        
    }
}


class InheritanceController: SyntaxBaseController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 单行注释
        /*
            多行注释
         */
        
//        let ve = InVehicle.init()
//        print(ve.description)
        
        let bicycle = InBicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print(bicycle.description)
    }
    
    /**
        文档注释
     */
    
    /// 示例
    ///
    /// - Parameter param: 参数
    func demo(param: String) -> Void {
        
    }

}
