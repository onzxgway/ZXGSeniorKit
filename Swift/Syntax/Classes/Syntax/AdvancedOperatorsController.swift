//
//  AdvancedOperatorsController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/10/4.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    高级运算符
        1.位运算符
        2.溢出运算符
        3.数值溢出
        4.优先级和结合性
        5.运算符函数
        6.前缀和后缀运算符
        7.复合赋值运算符
        8.等价运算符
 9.自定义运算符
 10.自定义中缀运算符的优先级
 */

// MARK: - 1.位运算符 (按位左移、右移运算符 待学习)
func ao_One() {  // ~ & | ^
    // 按位取反运算符
    let initialBits: UInt8 = 0b00001111
    print(initialBits)
    let invertedBits = ~initialBits
    print(invertedBits)
    // 按位与运算符
    let firstSixBits: UInt8 = 0b11111100
    let lastSixBits: UInt8  = 0b00111111
    let middleFourBits = firstSixBits & lastSixBits // 等于 00111100
    print(middleFourBits)
    // 按位或运算符
    let someBits: UInt8 = 0b10110010
    let moreBits: UInt8 = 0b01011110
    let combinedbits = someBits | moreBits // 等于 11111110
    print(combinedbits)
    // 按位异或运算符
    let firstBits: UInt8 = 0b00010100
    let otherBits: UInt8 = 0b00000101
    let outputBits = firstBits ^ otherBits // 等于 00010001
    print(outputBits)
    // 按位左移、右移运算符
    
}

// MARK: - 2.溢出运算符
func ao_Two() {
    var potentialOverflow = Int16.max   // 32767，这是 Int16 能容纳的最大整数
    // potentialOverflow += 1  //  这里会报错, 赋值时为过大或者过小的情况提供错误处理，能让我们在处理边界值时更加灵活。
    print(potentialOverflow)
    
    // 当你希望的时候也可以选择让系统在数值溢出的时候采取截断处理，而非报错。Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的
    potentialOverflow &+= 1
    print(potentialOverflow)
    
    var animalHWeight = Int8.min
    print(animalHWeight)
    animalHWeight &-= 1
    print(animalHWeight)
}

// MARK: - 3.数值溢出
/*
 对于无符号与有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小数。同样地，当发生下溢时，它们会从所能容纳的最小数变成最大数。
 */
func ao_Three() {
    var unsignedOverflow = UInt8.max
    print(unsignedOverflow)
    // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
    unsignedOverflow = unsignedOverflow &+ 1
    // 此时 unsignedOverflow 等于 0
    /*
     11111111 =255
     &+  00000001
     = 1 00000000 =0
     */
    print(unsignedOverflow)
    
    print("-------------------------")
    
    var unsignedOverflowMin = UInt8.min
    print(unsignedOverflowMin)
    // unsignedOverflowMin 等于 UInt8 所能容纳的最小整数 0
    unsignedOverflowMin = unsignedOverflowMin &- 1
    // 此时 unsignedOverflow 等于 255
    /*
     00000000  =0
     &-  00000001
     =   11111111  =255
     */
    print(unsignedOverflowMin)
    
    print("-------------------------")
    
    var signedOverflow = Int8.min
    // signedOverflow 等于 Int8 所能容纳的最小整数 -128
    print(signedOverflow)
    signedOverflow = signedOverflow &- 1
    // 此时 signedOverflow 等于 127
    /*
     10000000  =-128
     &-  00000001
     =   01111111  =127
     Sign
     bit
     */
    print(signedOverflow)
}

// MARK: - 4.优先级和结合性
func ao_Four() {
    
}

// MARK: - 5.运算符函数
/*
    类和结构体可以为现有的运算符提供自定义的实现。这通常被称为运算符重载。
 */
func ao_Five() {
    let vector = Vector2D(x: 3.0, y: 1.0)
    let anotherVector = Vector2D(x: 2.0, y: 4.0)
    let combinedVector = vector + anotherVector
    // combinedVector 是一个新的 Vector2D 实例，值为 (5.0, 5.0)
    print(combinedVector)
}

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D.init(x: left.x + right.x, y: left.y + right.y)
    }
}

// MARK: - 6.前缀和后缀运算符
func ao_Six() {
    let positive = Vector2D(x: 3.0, y: 4.0)
    let negative = -positive
    print(negative)
    // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
    let alsoPositive = -negative
    // alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例
    print(alsoPositive)
}

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D.init(x: -vector.x, y: -vector.y)
    }
    //    static postfix func - (vector: Vector2D) -> Vector2D {
    //        return Vector2D.init(x: vector.x + 1, y: vector.y + 1)
    //    }
}

// MARK: - 7.复合赋值运算符
/*
 不能对默认的赋值运算符（=）进行重载。只有复合赋值运算符可以被重载。同样地，也无法对三元条件运算符 （a ? b : c） 进行重载。
 */
func ao_Seven() {
    var original = Vector2D(x: 1.0, y: 2.0)
    let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
    original += vectorToAdd
    // original 的值现在为 (4.0, 6.0)
    print(original)
}

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// MARK: - 8.等价运算符
/*
    通常情况下，自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为相等运算符（==）与不等运算符（!=）。
 
    多数简单情况下，您可以使用 Swift 为您提供的等价运算符默认实现。Swift 为以下数种自定义类型提供等价运算符的默认实现：
 
    只拥有存储属性，并且它们全都遵循 Equatable 协议的结构体
    只拥有关联类型，并且它们全都遵循 Equatable 协议的枚举
    没有关联类型的枚举
 
    在类型原始的声明中声明遵循 Equatable 来接收这些默认实现。
 */
func ao_Eight() {
    let twoThree = Vector2D(x: 2.0, y: 3.0)
    let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
    if twoThree == anotherTwoThree {
        print("These two vectors are equivalent.")
    }
    // 打印“These two vectors are equivalent.”
    
    let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
    let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
    if twoThreeFour == anotherTwoThreeFour {
        print("These two vectors are also equivalent.")
    }
    // 打印“These two vectors are also equivalent.”
}

extension Vector2D: Equatable {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

// MARK: - 9.自定义运算符
func ao_Nine() {
    var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
    print(toBeDoubled)
    let afterDoubling = +++toBeDoubled
    // toBeDoubled 现在的值为 (2.0, 8.0)
    // afterDoubling 现在的值也为 (2.0, 8.0)
    print(afterDoubling)
}

prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

// MARK: - 10.自定义中缀运算符的优先级
/*
 当定义前缀与后缀运算符的时候，我们并没有指定优先级。然而，如果对同一个值同时使用前缀与后缀运算符，则后缀运算符会先参与运算。
 */
func ao_Ten() {
    let firstVector = Vector2D(x: 1.0, y: 2.0)
    let secondVector = Vector2D(x: 3.0, y: 4.0)
    let plusMinusVector = firstVector +- secondVector
    // plusMinusVector 是一个 Vector2D 实例，并且它的值为 (4.0, -2.0)
    print(plusMinusVector)
}

infix operator +-: AdditionPrecedence // 定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

class AdvancedOperatorsController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //        one()
        //        two()
        //        three()
        //        four()
        //        five()
        //        six()
        //        seven()
        //        eight()
        //        nine()
        //        ten()
        
        review()
    }

}

/*
    复习高级运算符 20190919
         1.位运算符
         2.溢出运算符
         3.数值溢出
         4.优先级和结合性
         5.运算符函数
         6.前缀和后缀运算符
         7.复合赋值运算符
         8.等价运算符
         9.自定义运算符
         10.自定义中缀运算符的优先级
 */
func review()  {
    
    // 1. 按位 非 与 或 异或
    let a: UInt8 = 0b00001111, b: UInt8 = 0b11110000
    print(a); print(~a); print(a & b); print(a | b); print(a ^ b)
    
    // 2. 溢出运算符 &+ &- &*
    let c: UInt = UInt.max
    print(c &+ 1)
    
    // 5.运算符函数
    let p1 = AOPerson.init(age: 18, house: 1)
    let p2 = AOPerson.init(age: 18, house: 1)
    print(p1 + p2)
    
    print(p1 -+ p2)
    
    print(-p1)
    
}


struct AOPerson {
    var age: Int = 0, house: Int = 0
}

infix operator -+: AdditionPrecedence
extension AOPerson {
    // 5.运算符函数
    static func + (left: AOPerson, right: AOPerson) -> AOPerson {
        return AOPerson.init(age: left.age + right.age, house: left.house + right.house)
    }
    // 6.前缀和后缀运算符
    static prefix func - (p: AOPerson) -> AOPerson {
        return AOPerson.init(age: -p.age, house: -p.house)
    }
    // 9.自定义运算符  10.自定义中缀运算符的优先级
    static func -+ (left: AOPerson, right: AOPerson) -> AOPerson {
        return AOPerson.init(age: left.age + right.age, house: left.house - right.house)
    }
}
