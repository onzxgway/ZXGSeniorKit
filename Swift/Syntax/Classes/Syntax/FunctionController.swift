//
//  FunctionController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/10.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    函数：是一段完成特定任务的独立代码片段。
 
    1.函数的定义与调用
    2.函数的参数与返回值
    3.函数参数标签和参数名称
    参数标签的使用能够让一个函数在调用时更有表达力，更类似自然语言，并且仍保持了函数内部的可读性以及清晰的意图。
    4.函数类型
    5.嵌套函数
 */

class FunctionController: SyntaxBaseController {
    
    // 4.1 使用函数类型
//    var mathFunction: (Int, Int) -> Int = addTwoInts

    override func viewDidLoad() {
        super.viewDidLoad()

        print(greet(person: "Anna"))
        print(greet(person: "Brian"))
        // 4. 函数类型
//        printMathResult(addTwoInts, 3, 5)
//        var currentValue = 3
//        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//        print("Counting to zero:")
//        // Counting to zero:
//        while currentValue != 0 {
//            print("\(currentValue)... ")
//            currentValue = moveNearerToZero(currentValue)
//        }
//        print("zero!")
//        // 3...
//        // 2...
//        // 1...
//        // zero!
        
        // 5.嵌套函数
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        // -4...
        // -3...
        // -2...
        // -1...
        // zero!
    }
    
    // 1.函数的定义与调用
    func greet(person: String) -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
    
}

// 给已有类型添加新功能。
// 2.函数的参数与返回值
extension FunctionController {
    // 2.1 无参数函数
    func greet() -> String {
        return ""
    }
    
    // 2.2 多参数函数
    func greet(person: String, alreadyGreeted: Bool) -> String {
        return ""
    }
    
    // 2.3 无返回值函数
    func greet_temp(person: String) {
        print("Hello, \(person)!")
    }
    
    // 2.4 多返回值函数
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    // 2.5 可选元组返回类型
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    // 2.6 隐式返回的函数
    // 任何一个可以被写成一行 return 语句的函数都可以忽略 return。
    func greeting(for person: String) -> String {
        return "Hello, " + person + "!"
    }
    
    func anotherGreeting(for person: String) -> String {
        return "Hello, " + person + "!"
    }
}

// 3.函数参数标签和参数名称
extension FunctionController {
    // 3.1 使用参数名称来作为参数标签
    func someFunction(firstParameterName: Int, secondParameterName: Int) {
        // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
    }
    
    // 3.2 指定参数标签
    func someFunction(argumentLabel parameterName: Int) {
        // 在函数体内，parameterName 代表参数值
    }
    
    func greet(person: String, from hometown: String) -> String {
        return "Hello \(person)!  Glad you could visit from \(hometown)."
    }
    
    // 3.3 忽略参数标签
    func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
        // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
    }
    
    // 3.4 默认参数值
    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
        // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
    }
    //    someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6)
    //    someFunction(parameterWithoutDefault: 4)
    
    // 3.5 可变参数
    // 注意：一个函数最多只能拥有一个可变参数。
    func arithmeticMean(_ numbers: Double...) -> Double {
        // 在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    //    arithmeticMean(1, 2, 3, 4, 5)
    //    arithmeticMean(3, 8.25, 18.75)
    
    // 3.6 输入输出参数
}


// 4.函数类型
extension FunctionController {
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    // 以上两个的函数类型都为 (Int, Int) -> Int
    func printHelloWorld() {
        print("hello, world")
    }
    // 以上函数类型为 () -> Void
    
    // 4.2 函数类型作为参数类型
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }
//    printMathResult(addTwoInts, 3, 5)
    
    // 4.3 函数类型作为返回类型
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
}


// 5.嵌套函数
/*
    你所见到的所有函数都叫全局函数（global functions），它们定义在全局域中。
 你也可以把函数定义在别的函数体中，称作 嵌套函数（nested functions）。
 
    默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
 */
extension FunctionController {
    
    func chooseStepFunctionCopy(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }
    
}
