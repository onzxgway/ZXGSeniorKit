//
//  CollectionTypeController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/9.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

// MARK: - 集合类型
/*
 Swift语言提供了数组（Array）、集合(Set)和字典(Dictionary)三种基本的集合类型用来存储值。
 数组是有序的可重复的，集合是无序不重复的，字典是无序的键值对，key不能重复。
 
 Swift 中的数组、集合和字典必须明确其中保存的键和值类型，这样就可以避免插入一个错误数据类型的值。同理，对于获取到的值你也可以放心，其数据类型是确定的。
 
 集合的可变性：
    如果创建一个数组、集合或字典并且把它分配成一个变量，这个集合将会是可变的。这意味着可以在创建之后添加、修改或者删除数据项。如果把数组、集合或字典分配成常量，那么它就是不可变的，它的大小和内容都不能被改变。
 */


// MARK: - 数组
/*
 定义：数组是有序列表存储相同类型的多个值。
 
 用法：  1.创建
        2.增删改查
        3.遍历
 */
struct Dog {
    
    var friends = Array<String>()
    var relationships = [String]() // 推荐使用
    // 1.创建
    func create(_ params: Int) -> Void {
        // 创建一个空数组
        var temp_1 = [Int]()
        temp_1.append(3)
//        print(temp_1.count)
        temp_1 = [] // 如果代码上下文中已经提供了类型信息，你可以使用空数组语句创建一个空数组。
//        print(temp_1.count)
        
        // 创建一个带有默认值的数组
        let temp_2 = Array.init(repeating: "heyhey", count: 8)
        print(temp_2)
        
        // 通过两个数组相加创建一个数组 (两数组类型必须相同)
        let temp_3 = Array.init(repeating: "woowoo", count: 2)
        let temp_4 = temp_3 + temp_2
        print(temp_4)
        
        // 用数组字面量构造数组
        let temp_5 = ["a", "b"]
        print(temp_5)
    }
    
    // 2.增删改查
    mutating func change() -> Void {
        // 增
        friends.append("Jack")
        friends += ["Rose", "Mark", "Lindda"]
        friends.insert("Andi", at: 0)
        if friends.isEmpty {
            print(friends)
        }
        
        // 查
        print(friends[0])
        print(friends.first ?? "")
        print(friends.last ?? "")
        
        // 改
        print("=======")
        print(friends)
        friends[0] = "kobe"
        friends[1...3] = ["James", "Tmac"]
        print(friends)
        
        // 删
        friends.remove(at: 1)
        print(friends)
        friends.removeFirst()
        print(friends)
        friends.removeLast()
        print(friends)
        friends.removeAll()
        print(friends)
    }
    
    // 3.遍历
    func over() -> Void {
        
        let ary = ["Kobe", "James", "Tmac"] + ["Yi", "Yao", "Wang"]
        for item in ary {
            print(item, terminator: "")
        }
        print("")
        for (index, value) in ary.enumerated() {
            print("Item \(String(index + 1)): \(value)")
        }
    }
}


// MARK: - 集合
/*
 定义：集合用来存储相同类型并且没有确定顺序的值。
 
 使用场景：当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组。
 
 用法：  1.创建
        2.增删改查
        3.遍历
 */
class Cat {
    
}

class CollectionTypeController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var dog = Dog.init()
        dog.over()
    }

}
