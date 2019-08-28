//
//  ErrorHandlingController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/21.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/** 错误处理
    1.表示与抛出错误
    2.处理错误
    3.指定清理操作
 */

/*
    关键知识点：
        1.什么是错误？
            答：Swift中遵循了Error协议的类型的实例表示错误。
        2.什么是throwing函数？
            答：一个标有 throws 关键字的函数被称作 throwing 函数。
 */

// MARK: - 1.表示与抛出错误
/*
    Swift中使用遵守Error协议的类型值表示错误。
 */
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class ClassError: Error {
    
}

struct StructError: Error {
    
}

class ErrorHandlingController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        try throwTest()
        
//        test()
        
//        do {
//            try nourish(with: "Beet-Flavored Chips")
//        } catch {
//            print("Unexpected non-vending-machine-related error: \(error)")
//        }
        
        processFile(filename: "mov")
        
    }
    
    func throwTest1() throws -> Void {
        throw ClassError.init()
    }
    func throwTest2() throws -> Void {
        throw StructError.init()
    }
    func throwTest3() throws -> Void {
        throw VendingMachineError.outOfStock
    }
    
    func test() {
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        do {
            try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            print("Success! Yum.")
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
// MARK: - 3.指定清理操作
    /*
        你可以使用 defer 语句在即将离开当前代码块时执行一系列语句。
     该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，或是由于诸如 return、break 的语句
     */
    func processFile(filename: String) {
        if filename.count > 0 {
            print("open filename")
            defer {
                print("close file")
            }
            print("deal file")
            // print("close file") 会在这里被调用，即作用域的最后。
        }
    }

}

// MARK: - 2.处理错误
/*
    Swift中有四种错误处理的方式：
        1.用 throwing 函数传递错误
        2.用 Do-Catch 处理错误
        3.将错误转换成可选值
        4.禁用错误传递
 */
class TestDemoClass {
    
    /*
        1.一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
        2.只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
     */
    func canThrowErrors() throws -> Void {
        
    }
    
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

func nourish(with item: String) throws {
    do {
        let vendingMachine = VendingMachine()
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

class TestOne {
 
    func someThrowingFunction() throws -> Int {
        return 888
    }
    
    // 3.将错误转换成可选值
    func test() -> Void {
        let x = try? someThrowingFunction()
        
        print(x)
        
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
        }
        print(y)
    }
    
}

// MARK: - 第一次总结 20190828
/*
    1.怎么表示错误？
        答：遵守了Error协议的类型实例表示错误。
    2.怎么处理错误？
        答： 一.throwing函数继续往外部抛
            二.do-catch处理
            三.try?
            四.try!
 */
