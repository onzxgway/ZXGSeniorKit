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
        2.增删、查（只能查询某个元素在不在集合中）
        3.遍历
        4.集合的操作
 */
class Cat {
    // 1.创建
    func jump() -> Void {
        // 方式一
        var heights = Set<String>()
        heights.insert("38")
        print(heights)
        heights = []
        print(heights)
        
        // 用数组字面量创建集合
//        var times: Set<String> = ["Morning", "Afternoon", "Night"]
        // 可简化为
        let times: Set = ["Morning", "Afternoon", "Night"]
        print(times)
    }
    
    // 2.增删 查
    func modify() -> Void {
        // 增
        var legs = Set<String>()
        legs.insert("front_right")
        legs.insert("front_left")
        legs.insert("back_right")
        legs.insert("back_left")
        
        if legs.isEmpty {
            assertionFailure("必须有🦵！！！")
        }
        else {
            print(legs)
        }
        
        // 删
        legs.remove("back_right")
        legs.remove("back_left")
        print(legs)
        
        // 查（只能查询某个元素在不在集合中）
        if legs.contains("Kobe") {
            print("YES")
        }
        else {
            print("NO")
        }
    }
    
    // 3.遍历
    func over() -> Void {
        let musics: Set = ["Classical", "Jazz", "Hip hop", "Hip hop", "Hip hop"] // 集合会自动去重
        
        for genre in musics {
            print("\(genre)")
        }
        
        // Swift 的 Set 类型没有确定的顺序，为了按照特定顺序来遍历一个集合中的值可以使用 sorted()方法，它将返回一个有序数组，这个数组的元素排列顺序由操作符 < 对元素进行比较的结果来确定。
        for (index, genre) in musics.sorted().enumerated() {
            print("\(index) + \(genre)")
        }
    }
    
    // 4.集合的操作
    func operate() -> Void {
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        /*
         基本集合操作
            使用 intersection(_:) 方法根据两个集合的交集创建一个新的集合。
            使用 symmetricDifference(_:) 方法根据两个集合不相交的值创建一个新的集合。
            使用 union(_:) 方法根据两个集合的所有值创建一个新的集合。
            使用 subtracting(_:) 方法根据不在另一个集合中的值创建一个新的集合。
         */
        
        let res_1 = oddDigits.union(evenDigits).sorted()
        print(res_1)
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        let res_2 = oddDigits.intersection(evenDigits).sorted()
        print(res_2)
        // []
        let res_3 = oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
        print(res_3)
        // [1, 9]
        let res_4 = oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
        print(res_4)
        // [1, 2, 9]
        
        /*
         集合成员关系和相等
             使用“是否相等”运算符（==）来判断两个集合包含的值是否全部相同。
             使用 isSubset(of:) 方法来判断一个集合中的所有值是否也被包含在另外一个集合中。
             使用 isSuperset(of:) 方法来判断一个集合是否包含另一个集合中所有的值。
             使用 isStrictSubset(of:) 或者 isStrictSuperset(of:) 方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
             使用 isDisjoint(with:) 方法来判断两个集合是否不含有相同的值（是否没有交集）。
         */
        let houseAnimals: Set = ["🐶", "🐱"]
        let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
        let cityAnimals: Set = ["🐦", "🐭"]
        
        print(houseAnimals.isSubset(of: farmAnimals))
        // true
        print(farmAnimals.isSuperset(of: houseAnimals))
        // true
        print(farmAnimals.isDisjoint(with: cityAnimals))
        // true
    }
}


// MARK: - 字典
/*
 定义：字典是一种无序的集合，它存储的是键值对之间的关系，其所有键和值需要是相同的类型，每个值（value）都关联唯一的键（key），键作为字典中这个值数据的标识符。。
 
 用法：  1.创建
        2.增删改查
        3.遍历
 */

struct Horse {
    // 1.创建
    func run() {
        // 方式一
//        var numOfHorse = Dictionary<String, Double>()
        var numOfHorse = [String: Double]() // 推荐使用
        numOfHorse["height"] = 183
        print(numOfHorse)
        numOfHorse = [:]
        print(numOfHorse)
        
        // 用字典字面量创建字典
//        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        // 简化为
        let airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        print(airports)
    }
    
    // 2.增删改查
    func modify() {
        var numOfHorse = [String: Double]() // 推荐使用
        
        // 增
        numOfHorse["height"] = 183
        numOfHorse["weight"] = 300
        print(numOfHorse)
        numOfHorse.updateValue(210, forKey: "length")
        print(numOfHorse)
        
        // 删
        numOfHorse.removeValue(forKey: "length")
        numOfHorse["height"] = nil
        print(numOfHorse)
        
        // 改
        numOfHorse.updateValue(3, forKey: "weight")
        print(numOfHorse)
        numOfHorse["weight"] = 300
        print(numOfHorse)
        
        // 查
        if let value = numOfHorse["weight"] {
            print(value)
        }
    }
    
    // 3.遍历
    func over() -> Void {
        let musics = ["1": "Classical", "2": "Jazz", "3": "Hip hop"]
        
        for (key, value) in musics {
            print("\(key): \(value)")
        }
        
        print([String](musics.keys))
        for value in musics.keys {
            print("\(value)")
        }
        print([String](musics.keys).sorted())
        
        print([String](musics.values))
        for value in musics.values {
            print("\(value)")
        }
        print([String](musics.values).sorted())
    }
    
}


class CollectionTypeController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        var dog = Dog.init()
//        dog.over()
        
//        Cat.init().operate()
        
        let horse = Horse.init()
        horse.over()
    }

}
