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

class MemorySafetyController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        test()
//        test_one()
        test_two()
    }

}
