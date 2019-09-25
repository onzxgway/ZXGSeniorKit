//
//  GenericsController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/15.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    泛型是Swift最强大的特性之一。
        1.泛型解决的问题。
        2.泛型函数。
        3.类型参数。(占位类型参数)
        4.命名类型参数。(占位类型参数命名)
        5.泛型类型。
        6.泛型扩展。(泛型类型扩展)
        7.类型约束。
        8.关联类型。
        9.泛型Where语句。
        10.具有泛型Where子句的扩展。
        11.具有泛型Where子句的关联类型。
        12.泛型下标。
 */

// MARK: - 1.泛型解决的问题。
/*
    泛型解决：不同类型的数据，相同的操作逻辑，可以归并在一起。
 */
// swapTwoInts函数很好用，但是只能作用于Int类型，如果想交换两个String类型，或者Double类型值，则必须编写对应的函数
func swapTwoInts(_ a: inout Int, _ b: inout Int) -> Void {
    let temp = a
    a = b
    b = temp
}

func swapTwoStrings(_ a: inout String, _ b: inout String) -> Void {
    let temp = a
    a = b
    b = temp
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) -> Void {
    let temp = a
    a = b
    b = temp
}
// 以上三个函数的函数体是相同的，唯一的区别是它们接受的参数类型不同。实际应用中，需要一个更加灵活的函数来交换任意类型的值。泛型可以做到。



// MARK: - 2.泛型函数
// swapTwoInts 的泛型版本  占位类型
// T, U, V 占位符类型名，告诉编译器，我是占位符，不代表具体类型，调用的时候确定。
func swapTwoValues<T>(_ a: inout T, _ b: inout T) -> Void {
    let temp = a
    a = b
    b = temp
}

// MARK: - 5.泛型类型
// 5.泛型类型。
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<V: Equatable> { // Element是占位的类型参数
    var items = [V]()
    mutating func push(_ item: V) {
        items.append(item)
    }
    mutating func pop() -> V {
        return items.removeLast()
    }
}

class PPTDemo<T> {
    var coll: [T]?
}

// MARK: - 6.泛型类型扩展
// 扩展并不需要提供类型参数列表作为定义的一部分
extension Stack {
    var topItem: V? {
        return items.isEmpty ? nil : items.first
    }
}

// MARK: - 7.类型约束
// 7.1 类型约束语法
func someFunction<T: NSObject, U: Hashable>(_ someT: T, _ someU: U) -> Void {}

// 7.2 类型约束实践
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

func findIndex<T: Equatable>(ofString valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// MARK: - 8.关联类型
/*
 协议不能使用<T>形式声明泛型类型，必须使用关联类型
 */
protocol Container {
    associatedtype Item: Equatable // 8.2 给关联类型添加约束
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 8.1扩展现有类型来指定关联类型
extension IntStack: Container { // 非泛型类型指定关联类型
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Item {
        return items[i]
    }
}

// 8.3在关联类型约束里使用协议
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

//extension Stack: SuffixableContainer {
//    func suffix(_ size: Int) -> Stack<Element>.Suffix {
//
//    }
//}

extension Stack: Container {
    mutating func append(_ item: V) {
        items.append(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> V {
        return items[i]
    }
}

// MARK: - 9.泛型Where语句
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anthorContainer: C2) -> Bool
    where C1.Item == C2.Item, C1: Equatable {
        
        if someContainer.count != anthorContainer.count {
            return false
        }
        
        for i in 0..<someContainer.count {
            if someContainer[i] != anthorContainer[i] {
                return false
            }
        }
        
        return true
}

// MARK: - 10.具有泛型Where子句的扩展
extension Stack where V: Equatable {
    
}

// MARK: - 11.具有泛型Where子句的关联类型
protocol SystemContainer {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

protocol ComparableContainer: Container where Item: Comparable {
    
}

// MARK: - 12.泛型下标
extension Container {
    subscript<V: Sequence>(indices: V) -> [Item] where V.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

class GenericsController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
