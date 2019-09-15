//
//  InitController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/9.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    构造过程：
        使用类、结构体或枚举类型实例之前的准备过程。在新实例使用之前这个过程是必须的，它包括设置实例中每个存储属性的初始值 和 执行其它必须的设置或构造过程。
 
    如果实现构造过程：
            通过定义构造器来实现构造过程。
    构造器：
            创建类型新实例的特殊方法。与 Objective-C 中的构造器不同，Swift 的构造器没有返回值。
 */

// MARK: - 存储属性的初始赋值
/*
    存储属性的初始赋值
 
        类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。
        赋值时机：
            1.可以在构造器中为存储型属性设置初始值。
            2.也可以在定义存储型属性的时候分配默认值。
        注意：
        当你为存储型属性分配默认值或者在构造器中为设置初始值时，它们的值是被直接设置的，不会触发任何属性观察者。
        使用注意点：
            如果存储型属性的默认值都是相同的，推荐在定义的时候分配默认值的方式，好处是可以充分利用类型推断的功能，且构造器中的代码更简单清晰。
 */
struct Fahrenheit {
    var temperature: Double
    var location: String = "China" // 定义存储型属性时分配默认值
    
    // 不带形参的构造器
    init() {
        temperature = 32.0  // 构造器中为存储型属性设置初始值
    }
}


// MARK: - 自定义构造过程
/*
    自定义构造过程
        1.形参的构造过程
        2.形参命名和实参标签
        3.不带实参标签的构造器形参
        4.可选属性类型
        5.构造过程中常量属性的赋值
 
    总结：
        1.构造器的形参名称与实参标签。
        2.可选类型的属性将自动初始化为nil。
 */
struct Celsius {
    var temperatureInCelsius: Double
    // 1.形参的构造过程
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(devide: Double) {
        temperatureInCelsius = devide * 0.5
    }
}

struct Color {
    let red, green, blue: Double
    // 2.形参命名和实参标签
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
    
    // 3.不带实参标签的构造器形参
    init(_ celsius: Double){
        red = celsius
        green = celsius
        blue = celsius
    }
}

//  4.可选属性类型
//  5.构造过程中常量属性的赋值
class SurveyQuestion {
    let text: String
    var response: String? // 可选类型的属性将自动初始化为 nil，表示这个属性是特意在构造过程设置为空。
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

// MARK: -  默认构造器
/*
    默认构造器
         1.如果类为所有的存储属性赋了默认值，且没有提供任何自定义的指定构造器，那么Swift会给这些类提供一个默认构造器。
         2.结构体的逐一成员构造器。如果没有提供任何自定义的构造器， 那么Swift就会给结构体提供一个默认构造器，不管存储型属性有没有默认值。
 
    总结：
        类默认构造器：1.所有的存储属性赋了默认值 + 2.没有提供任何自定义的构造器
 
        类只会提供一个默认构造器
        结构体： 所有存储属性都有默认值时，会有一个默认构造器+一个逐一成员构造器，否则只有一个逐一成员构造器。
 */

// 会提供默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

struct AnHui {
    let area: Double = 17.8
    var citys: Int = 12
    var peoples: Int
}

// MARK: - 值类型的构造器代理
/*
    注意：
    在原始定义中，没有自定义构造器的前提下，才会生产默认构造器和成员构造器。扩展中有自定义构造器对原始类中默认构造器的产生没有影响。
 */

struct ISize {
    var width, height: Double
}

struct IPoint {
    var x = 0.0, y = 0.0
}

struct Area {
    var length = 10.0
    var width: Double
}

struct IRect {
    var origin = IPoint.init()
    var size = ISize.init(width: 0.0, height: 0.0)
    
    //    init() {}
    //
    //    init(origin: Point, size: Size) {
    //        self.origin = origin
    //        self.size = size
    //    }
    
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - size.width * 0.5
        let originY = center.y - size.height * 0.5
        self.init(origin: Point.init(x: originX, y: originY), size: size)
    }
}


// MARK: - 类的继承和构造过程
/*
 类里面的所有存储属性，包括所有继承自父类的属性，都必须在构造过程中设置初始值。
 
 指定构造器、便利构造器。
 
 规则一：指定构造器必须调用其直接父类的指定构造器。
 规则二：便利构造器必须调用同类中的其他构造器。
 规则三：便利构造器最后必须调用指定构造器。
 
 两段式构造过程： Swift中类的构造过程包含两个阶段。第一阶段，类中的每个存储属性赋一个初始值。当每个存储型属性的初始值被赋值后，第二阶段开始，它给每个类一个机会在新实例准备使用之前进一步自定义它们的存储型属性。

 
    构造器的继承和重写：
 
 */

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
    // 默认构造器（如果有的话）总是指定构造器
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        
        numberOfWheels = 2
    }
}

// 如果子类的构造器没有在阶段 2 过程中做自定义操作，并且父类有一个无参数的指定构造器，你可以在所有子类的存储属性赋值之后省略 super.init() 的调用。
class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() 在这里被隐式调用
    }
    
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

// MARK: - 指定构造器和便利构造器实践
/*
    构造器的自动继承：
     子类在默认的情况下不会继承父类的构造器。但是如果满足特定条件的话，父类的构造器是可以被自动继承的。
     假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则将适用：
     1.如果子类没有定义任何指定构造器，它将自动继承父类所有的指定构造器。
     2.如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承父类所有的便利构造器。
 */
class Food {
    var name: String
    
    // 指定构造器
    init(name: String) {
        self.name = name
    }
    
    // 便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }

    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingLiIt: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

// MARK: - 可失败构造器
/*
     * 枚举类型的可失败构造器
     * 带原始值的枚举类型的可失败构造器
     * 构造失败的传递
     * 重写一个可失败构造器
     * init!可失败构造器
 */
// 基本语法
// 定义：会创建一个类型为自身类型的可选类型的对象。
// 语法：init?
struct Animal {
    var species: String = "Kobe"
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
    func run(target location: String) -> Void {
        print("\(species) run to \(location)")
    }
}

// 枚举类型的可失败构造器
enum Province {
    case AnHui, JiangSu, ZheJiang
    init?(_ name: String) {
        switch name {
        case "A":
            self = .AnHui
        case "J":
            self = .JiangSu
        case "Z":
            self = .ZheJiang
        default:
            return nil
        }
    }
}

// 带原始值的枚举类型的可失败构造器
enum City: String {
    case SuZhou = "s", HangZhou = "h", NanJing = "n"
    // 默认自动生成可失败构造器
}
// 非可失败构造器没有返回值
// 构造失败的传递
class Product {
    var name: String?
    init?(name: String) {
        if name.isEmpty { return nil } // 只有可失败构造器才能返回nil
        self.name = name
    }
    
    convenience init?() {
        self.init(name: "[Unnamed]")
    }
}

class CartItem: Product {
    let quantity: Int
    
    init?(name: String, quantity: Int) {
        if quantity < 0 { return nil }
        self.quantity = quantity
        
        super.init(name: name)
    }
}

// 重写一个可失败构造器
/*
    可失败构造器 可被子类重写为 可失败构造器和不可失败构造器
    不可失败构造器只能被子类重写为不可失败构造器。
 */
class Document {
    var name: String?
    init() {
        
    }
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
// 重写为 可失败构造器
class AutomaticallyNamedDocument: Document {

    override init() {
        super.init()
    }
    
    override init?(name: String) {
        if name.isEmpty {
            super.init(name: "[Unnamed]")
        }
        else {
            super.init(name: name)
        }
    }
}
// 重写为 不可失败构造器
class UntitledDocument: Document {
    override init(name: String) {
        if name.isEmpty {
            super.init(name: "[Unnamed]")!
        }
        else {
            super.init(name: name)!
        }
    }
}

// init!可失败构造器
/*
    隐式解包的可失败构造器
    init!与init? 可以互相代理，可以互相重写。
    init 可以代理到 init!，不过，一旦 init! 构造失败，则会触发一个断言。
 */
class Vechile {
    var branch: String?
    init!(_ branch: String) {
        if branch.isEmpty { return nil }
        self.branch = branch
    }
    convenience init() {
        self.init("[AoTuo]")
    }
}

class Benzs: Vechile {
    override init?(_ branch: String) {
        super.init(branch)
    }
}

// MARK: - 必要构造器
/*
 1.所有子类必须实现该构造器。
 2.子类重写父类构造器时，子类的构造器前也要添加required修饰符，表明该构造器要求也应用于继承链后面的子类。有required关键字时候，不需要override。
 注意：如果子类继承的构造器能满足必要构造器的要求，则无需在子类中显示提供必要的构造器的实现。
 */
class AClass {
    required init() {
        
    }
}

final class ASubClass: AClass {
    required init() {

    }
}

// MARK: - 通过闭包或者函数设置属性的默认值
// 基类：没有继承于任何类的类 或者 没有父类的类称为基类
/*
 如果使用闭包或者函数来设置属性的默认值，请记住在闭包执行时，实例的其他部分都还没有初始化。这意味着你不能在闭包里面访问其他属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法。
 */
class DemoTClass {
    let someProperty = {
        return ""
    }()
    var age = 18.0
}

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        
        return temporaryBoard
    }()
    
}

class InitController: SyntaxBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let f = Fahrenheit.init()
//        print("\(f.location) temperature is \(f.temperature)° Fahrenheit")
//
//        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//        print("boilingPointOfWater is \(boilingPointOfWater)")
//        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//        print("freezingPointOfWater is \(freezingPointOfWater)")
        
        //        Color.init(white: 156.0)
        //        Color.init(188.0)
        
        //        let item = ShoppingListItem()
        //        AnHui.init(citys: <#Int#>, peoples: 111)
        
//        let res = City.init(rawValue: "x")
//        print(res)
        
//        let vechile = Vechile.init("BMW")
//        print(vechile!.branch)
    }
    
}
