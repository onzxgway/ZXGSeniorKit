//
//  AutomaticReferenceCountingController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/25.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    自动引用计算(ARC)
        注意：引用计数仅仅应用于类的实例。结构体和枚举是值类型，不是引用类型，不适用引用计数。
 
        1.自动引用计数的工作机制。
            引用计数原理：创建对象时，引用计数为一，有新的指针引用时，引用计数加一，指针不再指向时，引用计数减一，如果引用计数为零的话，回收内存。
        2.自动引用计数实践。
        3.类实例之间的循环强引用。
        4.解决实例之间的循环强引用。
        5.闭包的循环强引用。
        6.解决闭包的循环强引用。
 */


// MARK: - 2.自动引用计数实践
class FirstPerson {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

// MARK: - 3.类实例之间的循环强引用
class SecondPerson {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
        print("SecondPerson \(name) is being initialized")
    }
    deinit {
        print("SecondPerson \(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    weak var tenant: SecondPerson?
    init(unit: String) {
        self.unit = unit
        print("Apartment \(unit) is being initialized")
    }
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// MARK: - 4.解决实例之间的循环强引用
// 两种方法：1.弱引用。 2.无主引用。 3.无主引用和隐式解包可选值属性

// 1.弱引用 （适用范围：其它实例有更短的生命周期时使用）（人与公寓的例子，人可能没有公寓，公寓也可能没有主人）
// ARC会在引用的实例被销毁后，自动将其弱引用赋值为nil。并且因为弱引用需要在运行时允许被赋值为nil,所以它们会被定义为可选类型变量，而不是常亮。
// 注意： 当ARC设置弱引用为nil时，属性观察期不会被触发。
//       非可选类型的变量不允许被赋值为nil。


// 2.无主引用 （适用范围：其它实例有相同或者更长的生命周期时使用）（人与信用卡的例子，人可能没有信用卡，信用卡一定有主人）
// ARC不会在引用的实例被销毁后，自动将其无主引用赋值为nil。
// 注意： 无主引用，必须确保引用始终指向一个未销毁的实例。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("Customer \(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("CreditCard \(number) is being deinitialized")
    }
}


// 3.无主引用和隐式解包可选值属性（国家与城市的例子，每个国家必有首都，每个城市必属于一个国家）

class CCountry {
    let name: String
    var capitalCity: CCity!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = CCity.init(name: capitalName, country: self)
    }
    deinit {
        print("Country \(name) is being deinitialized")
    }
}

class CCity {
    let name: String
    unowned let country: CCountry
    init(name: String, country: CCountry) {
        self.name = name
        self.country = country
    }
    deinit {
        print("City \(name) is being deinitialized")
    }
}

// MARK: - 5.闭包的循环强引用
/*
    Swift 有如下要求：只要在闭包内使用 self 的成员，就要用 self.someProperty 或者 self.someMethod()（而不只是 someProperty 或 someMethod()）。这提醒你可能会一不小心就捕获了 self。
 */
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        else {
            return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}


// MARK: - 6.解决闭包的循环强引用
// 1.定义捕获列表     2.弱引用和无主引用

// 1.定义捕获列表
class DemoElement {
    
    let name: String
    
    // 如果闭包有参数列表和返回类型，把捕获列表放在它们前面
    lazy var someClosure: (Int, String) -> String = {
        [unowned self] (index: Int, stringToProcess: String) -> String in
        // 这里是闭包的函数体
        return ""
    }
    
    // 如果闭包没有指明参数列表或者返回类型，它们会通过上下文推断，那么可以把捕获列表和关键字 in 放在闭包最开始的地方：
    lazy var anthorClosure: () -> String = {
        [unowned self] in
        // 这里是闭包的函数体
        return ""
    }
    
    init(name: String) {
        self.name = name
    }
}

// 2.弱引用和无主引用


class AutomaticReferenceCountingController: SyntaxBaseController {
    
    var reference1: FirstPerson?
    var reference2: FirstPerson?
    var reference3: FirstPerson?
    
    var john: SecondPerson?
    var unit4A: Apartment?
    
    var jack: Customer?

    override func viewDidLoad() {
        super.viewDidLoad()

//        reference2 = FirstPerson.init(name: "kobe")
        
//        john = SecondPerson.init(name: "kobe")
//        unit4A = Apartment.init(unit: "4A")
//        john?.apartment = unit4A
//        unit4A?.tenant = john
        
//        jack = Customer.init(name: "James")
//        jack?.card = CreditCard.init(number: 1234_5678_9012_3456, customer: jack!)
        
//        _ = CCountry.init(name: "Canada", capitalName: "Ottawa")

        let paragraph = HTMLElement.init(name: "p", text: "hello, world!")
        print(paragraph.asHTML())
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            reference2 = nil
        
//            john = nil
//            unit4A = nil
        
//        jack = nil
    }
    
}
