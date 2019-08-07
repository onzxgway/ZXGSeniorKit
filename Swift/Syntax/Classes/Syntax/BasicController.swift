//
//  BasicController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/7.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

// MARK: - 常量和变量
/*
    常量和变量
        常量的值一旦设定就不能改变，而变量的值可以随意更改。
 
    命名规则：小驼峰规则 （使用与 Swift 保留关键字相同的名称作为常量或者变量名，你可以使用反引号（`）将关键字包围的方式将其作为名字使用）
 
    使用思路：
        1.如果你的代码中有不需要改变的值，请使用 let 关键字将它声明为常量。只将需要改变的值声明为变量。
 */

// MARK: - 数值型字面量
/*
 数值型字面量
 
 注意事项：
    1.为了增强可读性，整数和浮点数都可以添加额外的零或者下划线，并不会影响字面量
 */

// MARK: - 类型别名
/*
 类型别名
 
 注意方式：
    typealias Integer = Int
 */

class Car {
    
    let wheelCount = 4  // 类型推断
    let horsepower = 3_000_0.0 // 增强可读性
    var brand = "BMW"
    
    var seatAColor, seatBColor, seatCColor: String? // 类型注解
    
    var x = 0.0, y = 0.9, z = 0.0
    
    var `enum` = "hello"  // 少用或者不用
    
    func launch() -> Void {
        print(brand, terminator: "")
        print(`enum`)
    }
}


// MARK: - 元组
/*
    元组
 
    访问元组的方式共有三种，见下面demo
 
    使用场景：
        1.方法有多个值返回
 */
struct AirPlane {
    
    func launch() -> (Int, String, String, Array<String>) {
        return (18, "NewYorkCity", "USA", ["Jack", "Rose"])
    }
    
    func flight() -> (speed: Double, height: Double, weight: Double) {
        return (688.0, 10000.5, 300000.0)
    }
    
    func msg() -> Void {
        let (count, targetCity, targetCountry, flighter) = launch()
        print("本次航班飞往\(targetCountry)\(targetCity)，共载有\(count)名乘客，机长是\(flighter[0])先生，副机长是\(flighter[1])女士。")
        
//        let (sp, he, _) = flight()
//        print("目前速度是\(sp)，高度是\(he)。")
        
//        // 也可以通过下标访问
//        let condition = flight()
//        print("目前速度是\(condition.0)，高度是\(condition.1)。")
        
        // 还也可以名称访问
        let condition = flight()
        print("目前速度是\(condition.speed)，高度是\(condition.height)。")
    }
    
}


// MARK: - 可选类型
/*
 可选类型（optionals）来处理值可能缺失的情况。可选类型表示两种可能： 或者有值， 你可以解析可选类型访问这个值，或者根本没有值。
 
 解析方式：
    1. 强制解包
    2. 可选绑定
    3. 隐式解析 (可以把隐式解析可选类型当做一个可以自动解析的可选类型)
        隐式解析使用注意点：
            *. 如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。
            *. 如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。
            *. 仍然可以把隐式解析可选类型当做普通可选类型来判断它是否包含值，也可以在可选绑定中使用隐式解析可选类型来检查并解析它的值。
 
 注意事项：
    1. Swift 的 nil 和 Objective-C 中的 nil 并不一样。在 Objective-C 中，nil 是一个指向不存在对象的指针。在 Swift 中，nil 不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为 nil，不只是对象类型。
 
    2. 使用 ! 来获取一个不存在的可选值会导致运行时错误。使用 ! 来强制解析值之前，一定要确定可选包含一个非 nil 的值。
 */
class Lexus {
    
    // 如果声明一个可选常量或者变量但是没有赋值，它们会自动被设置为 nil。
    let origin: String?
    var creator: String?
    
    // 如果一个变量之后可能变成 nil 的话请不要使用隐式解析可选类型。
    var location: String! = "Japan" // 隐式解析
    
    // 调用构造方法，该实例即构造完成
    // 实例构造完成之前，常量必须赋值，且只可赋值一次
    init(_ creator: String, origin: String, location: String) {
        self.origin = origin
        self.creator = creator
        self.location = location
    }
    
    func welcome() -> Void {
        
        // 强制解包的方式，不推荐
        if creator != nil {
            print("\(creator!)是雷克萨斯的创始人。")
        }
        
    }
    
    func kawayi() {
        // 可选绑定
        if let name = creator {
            print("\(name)是雷克萨斯的创始人。")
        }
        else {
            print("XXX是雷克萨斯的创始人。")
        }
    }
    
    func sakula() {
        // 可选绑定
        if let name = creator, let year = origin, year != "1945" {
            print("\(name)于\(year)创建了雷克萨斯。")
        }
        else {
            print("XXX于yyyy年创建了雷克萨斯。")
        }
    }
    
    func japan() {
        // 隐式解析可选类型
        // 如果你在隐式解析可选类型没有值的时候尝试取值，会触发运行时错误。和你在没有值的普通可选类型后面加一个惊叹号一样。
        print("雷克萨斯是\(location)的企业。")
    }
}


// MARK: - 错误处理

// MARK: - 断言和先决条件

class BasicController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        Car.init().launch()
        
//        AirPlane.init().msg()
        
        Lexus.init("山下中暑", origin: "1956", location: "🇯🇵").japan()
    }

}
