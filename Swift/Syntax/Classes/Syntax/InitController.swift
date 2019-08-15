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

// MARK: - 存储属性的初始赋值
/*
    存储属性的初始赋值
 
        类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
        赋值时机：
            1.可以在构造器中为存储型属性设置初始值。
            2.也可以在定义存储型属性的时候分配默认值。
        注意：
        当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。
        使用注意点：
            如果存储型属性的默认值都是相同的，推荐在定义的时候分配默认值的方式，好处是可以充分利用类型推断的功能，且构造器中的代码更简单清晰。
 */
struct Fahrenheit {
    var temperature: Double
    var location: String = "China" // 定义存储型属性时分配默认值
    
    // 不带形参的构造器
    init() {
        temperature = 32.0  // 构造器中为存储型属性设置初始值
    }
}


// MARK: - 自定义构造过程
/*
    自定义构造过程
        1.形参的构造过程
        2.形参命名和实参标签
        3.不带实参标签的构造器形参
        4.可选属性类型
        5.构造过程中常量属性的赋值
 
    总结：
        1.构造器的形参名称与实参标签。
        2.可选类型的属性将自动初始化为nil。
 */
struct Celsius {
    var temperatureInCelsius: Double
    // 1.形参的构造过程
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(devide: Double) {
        temperatureInCelsius = devide * 0.5
    }
}

struct Color {
    let red, green, blue: Double
    // 2.形参命名和实参标签
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
    
    // 3.不带实参标签的构造器形参
    init(_ celsius: Double){
        red = celsius
        green = celsius
        blue = celsius
    }
}

//  4.可选属性类型
//  5.构造过程中常量属性的赋值
class SurveyQuestion {
    let text: String
    var response: String? // 可选类型的属性将自动初始化为 nil，表示这个属性是特意在构造过程设置为空。
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

// MARK: -  默认构造器
/*
    默认构造器
         1.如果类为所有的存储属性赋了默认值，且没有提供任何自定义的构造器，那么Swift会给这些类提供一个默认构造器。
         2.结构体的逐一成员构造器。如果没有提供任何自定义的构造器， 那么Swift就会给结构体提供一个默认构造器，不管存储型属性有没有默认值。
 
    总结：
        类默认构造器：1.所有的存储属性赋了默认值 + 2.没有提供任何自定义的构造器
        结构体默认构造器：1.没有提供任何自定义的构造器
 */

// 会提供默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

struct AnHui {
    let area: Double = 17.8
    var citys: Int = 12
    var peoples: Int
}

class InitController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let f = Fahrenheit.init()
        print("\(f.location) temperature is \(f.temperature)° Fahrenheit")
        
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        print("boilingPointOfWater is \(boilingPointOfWater)")
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        print("freezingPointOfWater is \(freezingPointOfWater)")
        
//        Color.init(white: 156.0)
//        Color.init(188.0)
        
//        let item = ShoppingListItem()
//        AnHui.init(citys: <#Int#>, peoples: 111)
    }

}
