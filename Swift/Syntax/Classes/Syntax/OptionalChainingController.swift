//
//  OptionalChainingController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/18.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    可选链
        可选链式调用 是一种可以在当前值可能为nil的可选值上 请求和调用属性、方法及下标。如果可选值有值，那么调用就会成功；如果可选值是 nil，那么调用将返回 nil。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil。
 
        可选链式调用返回的一定是可选值。
 
            1.使用可选链式调用代替强制展开
            2.为可选链式调用定义模型类
            3.通过可选链式调用访问属性
            4.通过可选链式调用来调用方法
            5.通过可选链式调用访问下标
            6.连接多层可选链式调用
            7.在方法的可选返回值上进行可选链式调用
 */

// MARK: - 1.使用可选链式调用代替强制展开
class OPerson {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

func oOne() {
    let john = OPerson()
    //    print(john.residence!.numberOfRooms) // 运行时错误
    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
    // 打印“Unable to retrieve the number of rooms.”
}

// MARK: - 2.为可选链式调用定义模型类
class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

// MARK: - 3.通过可选链式调用访问属性
func oTwo() {
    let john = OPerson()
    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
    // 打印“Unable to retrieve the number of rooms.”
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    john.residence?.address = someAddress // 通过 john.residence 来设定 address 属性也会失败，因为 john.residence 当前为 nil。 上面代码中的赋值过程是可选链式调用的一部分，这意味着可选链式调用失败时，等号右侧的代码不会被执行。
    
    john.residence?.address = createAddress() // 没有任何打印消息，可以看出 createAddress() 函数并未被执行。
}

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

// MARK: - 4.通过可选链式调用来调用方法
/*
    通过可选链式调用方法
    没有返回值的方法，也会返回()空元祖。
 
    如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是 Void?
 */
func oThree() -> () {
    let john = OPerson()
    if john.residence?.printNumberOfRooms() != nil {
        print("It was possible to print the number of rooms.")
    } else {
        print("It was not possible to print the number of rooms.")
    }
    // 打印“It was not possible to print the number of rooms.”
}

// MARK: - 5.通过可选链式调用访问下标
func oFour() -> Void {
    let john = OPerson()
    // 通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
    // 打印“Unable to retrieve the first room name.”
}

// 访问可选类型的下标
func oFive() -> Void {
    var testScores = ["Dave": [86, 82, 84],
                      "Bev": [79, 94, 81]]
    testScores["Dave"]?[0] = 91
    testScores["Bev"]?[0] += 1
    testScores["Brian"]?[0] = 72
    
    // "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
}

// MARK: - 6.连接多层可选链式调用
func oSix() -> Void {
//    通过可选链式调用访问一个 Int 值，将会返回 Int?，无论使用了多少层可选链式调用。
//    类似的，通过可选链式调用访问 Int? 值，依旧会返回 Int? 值，并不会返回 Int??。
}

// MARK: - 7.在方法的可选返回值上进行可选链式调用
func oSeven() -> Void {
    let john = OPerson()
    if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
        print("John's building identifier is \(buildingIdentifier).")
    }
    // 打印“John's building identifier is The Larches.”
    
    if let beginsWithThe =
        john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        // 在方法的圆括号后面加上问号是因为你要在 buildingIdentifier() 方法的可选返回值上进行可选链式调用，而不是 buildingIdentifier() 方法本身。
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
    }
    // 打印“John's building identifier begins with "The".”
}

class OptionalChainingController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        oOne()
//        oTwo()
        oThree()
    }

}
