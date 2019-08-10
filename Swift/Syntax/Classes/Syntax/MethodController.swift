//
//  MethodController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/9.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit
/*
    方法
        定义：与特定类型关联的函数叫方法。
 
    分类：
        1.实例方法
        2.类型方法  （相当于OC中的类方法）
 
    类、结构体和枚举皆可声明实例方法 + 类型方法。
 */

// MARK: - 实例方法
/*
    实例方法
 
    注意点：
        1.在实例方法中修改值类型
            结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
        2.在可变方法中给 self 赋值
        3.枚举的可变方法可以把 self 设置为同一枚举类型中不同的成员。
 */
class Counter {
    var count = 0
    func increment() {
        count += 1
        print(count)
    }
    func increment(by amount: Int) {
        count += amount
        print(count)
    }
    func reset() {
        count = 0
        print(count)
    }
}

struct Pointt {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x // 如果不使用 self 前缀，Swift会认为 x 的两个用法都引用了名为 x 的方法参数。
    }
    // 在实例方法中修改值类型
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    // 在可变方法中给 self 赋值
    mutating func moveByValue(x deltaX: Double, y deltaY: Double) {
        self = Pointt(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    // 三态切换的枚举
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}


// MARK: - 类型方法
/*
 类型方法
 
 注意点：
    1.可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。计算属性也一样。
 
    2. 实例方法可调用类型方法，类型方法不可调用实例方法。
 */


class MethodController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let counter = Counter()
        // 初始计数值是0
        counter.increment()
        // 计数值现在是1
        counter.increment(by: 5)
        // 计数值现在是6
        counter.reset()
        // 计数值现在是0
        
        let somePoint = Pointt(x: 4.0, y: 5.0)
        if somePoint.isToTheRightOf(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        
        var point = Pointt(x: 1.0, y: 1.0)
        point.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(point.x), \(point.y))")
        var point_2 = Pointt(x: 1.0, y: 1.0)
        point_2.moveByValue(x: 2.0, y: 3.0)
        print("The point is now at (\(point.x), \(point.y))")
        
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        // ovenLight 现在等于 .high
        ovenLight.next()
        // ovenLight 现在等于 .off
    }

}
