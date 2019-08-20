//
//  ClosureController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/19.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
 
    Swift中的闭包与OC中的blocks,其他语言的Lambdas（匿名函数）比较相似。
 
        一：闭包表达式
        二：尾随闭包
            闭包表达式作为函数或者方法的最后一个参数。
        三：值捕获
        四：闭包是引用类型
            函数和闭包都是引用类型。
        五：逃逸闭包
            当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
        六：自动闭包
            自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。
 */
class Closures {
    // 字面量的方式声明一个名称为names的不可变字符串数组。
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    
    // 一：闭包表达式
    func test() -> Void {
        
        // 闭包表达式语法
        let operater = {(s1: String, s2: String) -> Bool in
            return s1 > s2
        }
        
        print(names.sorted(by: operater))
        
        // 根据上下文推断类型
        print(names.sorted(by: { s1, s2 in return s1 > s2 }))
        
        // 单表达式闭包的隐式返回
        print(names.sorted(by: { s1, s2 in s1 < s2 }))
        
        // 参数名称缩写
        print(names.sorted(by: { $0 > $1 }))
        
        // 运算符方法
        print(names.sorted(by: < ))
        
    }
    
    // 二：尾随闭包
    /*
        使用场景：闭包表达式作为函数或者方法的最后一个参数。
     */
    func test1() -> Void {
        someFunctionThatTakesAClosure(param: "Kobe") {
            print("kobe")
        }
        
        someTwo(par: "James") { (s1: String, s2: String) -> Bool in
            return s1 > s2
        }
        
        someTwo(par: "T-Mac") {
            $0 < $1
        }
        
        someTwo(par: "Iverson", closure: <)
        
        // 如果闭包表达式是函数或者方法的唯一参数的话，当你使用尾随闭包时，可以省略()。
        print(names.sorted { $0 > $1 })
        
        
        let numbers = [16, 58, 510]
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let strings = numbers.map { (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(strings)
    }
    
    func someFunctionThatTakesAClosure(param: String, closure:() -> Void) {
        
    }
    
    func someTwo(par: String, closure: (String, String) -> Bool) {
        
    }
    
    // 三：值捕获
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        
        // 嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
        func incrementer() -> Int {
            // 即使定义这些常量和变量的原作用域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。
            runningTotal += amount
            return runningTotal
        }
        
        return incrementer
    }
}

// 五：逃逸闭包
class OtherClass {
    var x = 10
    var completionHandlers: [() -> Void] = []
    
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    
    // 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

// 六：自动闭包
class AutoClass {
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    
    func serve(customer customerProvider: () -> String) {
        print("Now serving \(customerProvider())")
    }
    
    func serve1(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())")
    }
    
    func launch() -> Void {
        let customerProvider = { self.customersInLine.remove(at: 0) }
        serve(customer: customerProvider)
        
        serve1(customer: self.customersInLine.remove(at: 0))
    }
}

// 逃逸闭包 + 自动闭包
class AnotherClass {
    var x = 10
    var completionHandlers: [() -> String] = []
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    
    func collectCustomerProviders(completionHandler: @autoclosure @escaping () -> String) {
        completionHandlers.append(completionHandler)
    }
    
    // 将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self
    func doSomething() {
        collectCustomerProviders(completionHandler: self.customersInLine.remove(at: 0))
        collectCustomerProviders(completionHandler: self.customersInLine.remove(at: 0))
    }
}

class ClosureController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let obj = Closures.init()
//        let fun = obj.makeIncrementer(forIncrement: 10)
//        print(fun())
        
//        let instance = OtherClass()
//        instance.doSomething()
//        print(instance.x)
//
//        instance.completionHandlers.first!()
//        print(instance.x)
        
        let instance = AutoClass.init()
        instance.launch()
    }
    
    func ordered() -> Void {
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        let reversedNames = names.sorted(by: backward)
        
        print(reversedNames)
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

}
