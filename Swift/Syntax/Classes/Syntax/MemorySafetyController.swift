//
//  MemorySafetyController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/15.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    内存安全
        1.理解内存访问冲突
        2.内存访问性质
        3.In-Out 参数的访问冲突
        4.方法里 self 的访问冲突
        5.属性的访问冲突
 */

// MARK: - 1.理解内存访问冲突
func test() -> Void {
    // 内存的访问（包含读和写）
    let one = 1 // 内存的写
    print("We are number \(one)") // 内存的读
    
    // 内存访问冲突发生在尝试同时访问同一个存储地址的时候。一个动作正在写的过程中，另一个动作有可能去读取，那么错误就有可能发生。
}

// MARK: - 2.内存访问性质
func test_one() -> Void {
    /*
     冲突会发生在当你有两个访问符合下列的情况：
        1.至少有一个是写访问
        2.它们访问的是同一个存储地址
        3.它们的访问在时间线上部分重叠
     */
    /*
        如果一个访问不可能在其访问期间被其它代码访问，那么就是一个瞬时访问。
     */
}

// MARK: - 3.In-Out 参数的访问冲突
var stepSize = 1

func test_two() -> Void {
    // ---
//    test_two_test(&stepSize) // 错误：stepSize 访问冲突
    
    
    // ---
    // 解决方式：显式拷贝
    var copyOfStepSize = stepSize
    test_two_test(&copyOfStepSize)
    // 更新原来的值
    stepSize = copyOfStepSize
    // stepSize 现在的值是 2
    print(stepSize)
    
    
    // ---
    var playerOneScore = 42
    var playerTwoScore = 30
//    balance(&playerOneScore, &playerOneScore) // 错误：playerOneScore 访问冲突 ，因为它会发起两个写访问，同时访问同一个的存储地址。
    
    // ---
    balance(&playerOneScore, &playerTwoScore)  // 正常
}

// 一个函数会对它所有的 in-out 参数进行长期写访问。in-out 参数的写访问会在所有非 in-out 参数处理完之后开始，直到函数执行完毕为止。如果有多个 in-out 参数，则写访问开始的顺序与参数的顺序一致。
// 长期访问的存在会造成一个结果，你不能在访问以 in-out 形式传入后的原变量，即使作用域原则和访问权限允许——任何访问原变量的行为都会造成冲突。
func test_two_test(_ number: inout Int) {
    number += stepSize
}
// 错误：stepSize 访问冲突。同一块内存的读和写访问重叠了，就此产生了冲突。
// 解决方法: 是显示拷贝一份 stepSize

// 长期写访问的存在还会造成另一种结果，往同一个函数的多个 in-out 参数里传入同一个变量也会产生冲突，例如：
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

// MARK: -
// MARK: -
// MARK: -

// MARK: - 4.方法里 self 的访问冲突
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth() {// 一个结构体的 mutating 方法会在调用期间对 self 进行写访问。
        health = Player.maxHealth // 一个对于 self 的写访问会从方法开始直到方法 return。在这种情况下，restoreHealth() 里的其它代码不可以对 Player 实例的属性发起重叠的访问。
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

// MARK: - 5.属性的访问冲突
// 全局变量
var playerInformation = (health: 15, energy: 75)
var holly = Player(name: "Holly", health: 10, energy: 10)

func temp() {
    /*
     balance(&playerInformation.health, &playerInformation.energy) // 错误：playerInformation 的属性访问冲突
     print(playerInformation)
     
     balance(&holly.health, &holly.energy)  // 错误
     print(holly)
     */
    /* 如结构体，元组和枚举的类型都是由多个独立的值组成的，例如结构体的属性或元组的元素。因为它们都是值类型，修改值的任何一部分都是对于整个值的修改，意味着其中一个属性的读或写访问都需要访问整一个值。
     
     上面的例子里，传入同一元组的元素对 balance(_:_:) 进行调用，产生了冲突，因为 playerInformation 的访问产生了写访问重叠。playerInformation.health 和 playerInformation.energy 都被作为 in-out 参数传入，意味着 balance(_:_:) 需要在函数调用期间对它们发起写访问。任何情况下，对于元组元素的写访问都需要对整个元组发起写访问。这意味着对于 playerInfomation 发起的两个写访问重叠了，造成冲突。
     */
    someFunction()
}

// 在实践中，大多数对于结构体属性的访问都会安全的重叠。例如，将上面例子里的变量 holly 改为本地变量而非全局变量，编译器就会可以保证这个重叠访问是安全的
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // 正常
    print(oscar)
    
    /*
     限制结构体属性的重叠访问对于保证内存安全不是必要的。保证内存安全是必要的，但因为访问独占权的要求比内存安全还要更严格——意味着即使有些代码违反了访问独占权的原则，也是内存安全的，所以如果编译器可以保证这种非专属的访问是安全的，那 Swift 就会允许这种行为的代码运行。特别是当你遵循下面的原则时，它可以保证结构体属性的重叠访问是安全的：
     
        你访问的是实例的存储属性，而不是计算属性或类的属性
        结构体是本地变量的值，而非全局变量
        结构体要么没有被闭包捕获，要么只被非逃逸闭包捕获了
     
        如果编译器无法保证访问的安全性，它就不会允许那次访问。
     */
}


class MemorySafetyController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test()
//        test_one()
        test_two()
    }

    func test_four() {
        var oscar = Player(name: "Oscar", health: 10, energy: 10)
        var maria = Player(name: "Maria", health: 5, energy: 10)
        oscar.shareHealth(with: &maria)     // 正常
        //        oscar.shareHealth(with: &oscar)     // 错误：oscar 访问冲突
    }
}
