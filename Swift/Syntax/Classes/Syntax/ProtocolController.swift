//
//  ProtocolController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    协议：有属性(实例 + 类型)和方法(实例，构造器 + 类型)的声明，没有实现。
 
         1.协议语法
         2.属性要求
         3.方法要求
         4.异变方法要求
         5.构造器要求
 
         6.协议作为类型
         7.代理设计模式（委托设计模式）
         8.在扩展里添加协议遵循
         9.有条件的遵循协议
 
         10.在扩展里声明采纳协议
            即使满足了协议的所有要求，类型也不会自动遵循协议，必须显示的遵循协议。
         11.协议类型的集合
         12.协议的继承
            协议是多继承的。
         13.类专属的协议
 
         14.协议合成
         15.检查协议的一致性
         16.可选的协议要求
         17.协议扩展
 */

// MARK: - 1.协议语法
protocol FirstProtocol {
    
}
protocol SecondProtocol {
    
}

// 遵循多个协议时，各协议之间用逗号（,）分隔
struct Demo1: FirstProtocol, SecondProtocol {
    
}
class SupClass {
    
}
// 若一个拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔
class DemoClass: SupClass, FirstProtocol, SecondProtocol {
    
}

// MARK: - 2.属性要求
/*
    分为： 1.实例属性 + 2.类型属性
 
    1.协议声明的属性，既可以被实现为存储属性，也可以被实现为计算属性。
    2.协议声明的可选/不可选类型属性，类型在实现的时候，不能更改可选性。
    3.只读属性，可以被类型实现为 只读 / 可读可写，
 */
protocol SomeProtocol {
    var age: Int { get }
    var name: String { set get }
    var sup: SupClass { get }
    var hometown: String? { set get }
    
    static var someTypeProperty: Int { get set } // 当类类型遵循协议时，除了static关键字，还可以用class关键字来声明类型属性。
}

class SomeClassPro: SomeProtocol {
    static var someTypeProperty: Int = 6
    
    var age: Int { // 只读计算
        return 18
    }
    var name: String = ""
    let sup: SupClass = SupClass.init() // 只读存储
    var hometown: String?
}

// MARK: - 3.方法要求
protocol AnthorProtocol {
    func random() -> Double
    static func someTypeMethod()
}

class SomeAnthorClass: AnthorProtocol {
    func random() -> Double {
        return 0.0
    }
    
    static func someTypeMethod() {
        
    }
    
}

class LinearCongruentialGenerator: AnthorProtocol, RandomNumberGenerator {
    
    let m = 139968.0, a = 3877.0, c = 29573.0
    var lastRandom = 42.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
    
    static func someTypeMethod() {
        
    }
    
    
}

// MARK: - 4.异变方法要求
/*
    实现协议中的mutating方法时，若是类类型则不用写mutating关键字。而对于结构体和枚举，则必须写mutating关键字。
 */
protocol Togglable {
    mutating func toggle() -> Void
}

enum OnOffSwitch: Togglable {
    mutating func toggle() {
        switch self {
        case .On:
            self = .Off
        default:
            self = .On
        }
    }
    case On, Off
}

// MARK: - 5.构造器要求
/*
    * 协议构造器要求的类实现
        1.协议构造器可被实现为指定构造器或是便利构造器。
        2.无论是作为指定构造器还是便利构造器，你都必须为构造器实现添加required修饰符。
 
        注意：如果类被标记为final，那么不需要在协议构造器的实现中使用required修饰符，因为final类不能有子类。
    * 可失败构造器要求
        遵循协议的类型可以通过可失败构造器或不可失败构造器来满足协议中定义的可失败构造器的要求。协议中定义的非可失败构造器要求可以通过非可失败构造器或隐式解包可失败构造器来满足。
 */
protocol AProtocol {
    init(params: Int)
}

class ABCClass {
    init(params: Int) {
        
    }
}

class DEMOClass: ABCClass, AProtocol {
    // 如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注required 和 override。
    override required init(params: Int) {
        super.init(params: params)
    }
}

protocol BProtocol {
     init(argument: Int)
}

class DemoClassB: BProtocol {
    // 便利构造器，必须调用其他的便利，或者是指定构造器。
    required convenience init(argument: Int) {
        self.init()
    }
}

final class ABCSubClass: AProtocol {
    required init(params: Int) {
        
    }
}

protocol CProtocol {
    init?(name: String) // 协议定义了(可失败)构造器
}

class CClass: CProtocol {
    // 类型遵守协议方式一 可失败构造器
    //    required init?(name: String) {
    //
    //    }
    // 类型遵守协议方式二 不可失败构造器
    required init(name: String) {
        
    }
}

protocol DProtocol {
    init(name: String) // 协议定义了不可失败构造器
}

class DClass: DProtocol {
    // 类型遵守协议方式一 隐式解包可失败构造器
    required init!(name: String) {
        
    }
    // 类型遵守协议方式二 不可失败构造器
    //    required init(name: String) {
    //
    //    }
}


// MARK: - 6.协议作为类型
/*
     作为函数、方法或构造器中的参数类型或返回值类型
     作为常量、变量或属性的类型
     作为数组、字典或其他容器中的元素类型
 */
class Dice {
    let sides: Int  // 属性赋值有两个地方，一声明的时候赋默认值。二在构造器中设置初始值。
    var generator: RandomNumberGenerator // 常亮赋值 不论以任何方式 都只能赋值一次。
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
}

// MARK: - 7.代理设计模式（委托设计模式）
protocol DiceGame {
    var dice: Dice { get }
    func play() -> Void
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25 // 声明属性的时候赋默认值
    let dice: Dice = Dice(sides: 6, generator: LinearCongruentialGenerator.init())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
    }
    func play() {
        
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        
    }
    func gameDidEnd(_ game: DiceGame) {
        
    }
}

// MARK: - 8.在扩展里添加协议遵循
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension ProtocolController: TextRepresentable {
    var textualDescription: String {
        return "A \(4)-sided dice"
    }
}

// MARK: - 9.有条件的遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// MARK: - 10.在扩展里声明采纳协议
/*
    即使满足了协议的所有要求，类型也不会自动遵循协议，必须显示的遵循协议。
 */
// MARK: - 11.协议类型的集合
protocol EProtocol {
    var array: Array<TextRepresentable> { set get }
}

// MARK: - 12.协议的继承
/*
    协议是多继承的。
*/
protocol InheritingProtocol: SomeProtocol, AnthorProtocol {
    // 这里是协议的定义部分
}

// MARK: - 13.类专属的协议
/*
    你通过添加 AnyObject 关键字到协议的继承列表，就可以限制协议只能被类类型采纳
    该协议只能被 引用类型 采纳，不能被值类型采纳。
 */
protocol SomeClassOnlyProtocol: AnyObject {
    
}

// MARK: - 14.协议合成
/*
     使用 AProtocol & BProtocol 的形式。
     也可以 AClass & BProtocol 的形式。 任意AClass及其子类，并且遵循BProtocol协议。
 */
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct DPerson: Named, Aged {
    var name: String
    var age: Int
}

class Launch {
    func wishHappyBirthday(to celebrator: Named & Aged) -> Void {
        
    }
    func launch() -> Void {
        let p = DPerson.init(name: "kobe", age: 18)
        wishHappyBirthday(to: p)
    }
}

// MARK: - 15.检查协议的一致性
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415926
    var radius: Double
    
    init(radius: Double) {
        self.radius = radius
    }
    
    var area: Double {
        return pi * radius * radius
    }
    
    func original() -> Double {
        return 999.0
    }
}

class Country: HasArea {
    var area: Double
    
    init(area: Double) {
        self.area = area
    }
}

class BAnimal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

// MARK: - 16.可选的协议要求
/*
    定义：协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。
 
    声明方法：在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上 @objc 属性。
 
    实现类型的要求：标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
 
    注意事项：
        1.使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
 */
@objc protocol MyViewDataSource {
    @objc optional func test() -> String
    @objc optional var age: Int { get }
}

class TempClass: MyViewDataSource {
    func test() -> String {
        return ""
    }
}

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class BCounter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        // 这里使用了两层可选链式调用。
        // 首先，由于 dataSource 可能为 nil，因此在 dataSource 后边加上了 ?，以此表明只在 dataSource 非空时才去调用 increment(forCount:) 方法。
        // 其次，即使 dataSource 存在，也无法保证其是否实现了 increment(forCount:) 方法，因为这个方法是可选的。因此，increment(forCount:) 方法同样使用可选链式调用进行调用，只有在该方法被实现的情况下才能调用它，所以在 increment(forCount:) 方法后边也加上了 ?。
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// MARK: - 17.协议扩展
/*
    在协议中可以基于协议本身来实现这些功能。
 
   通过协议扩展，所有遵守协议的类型，都能自动获得这个扩展所增加的方法实现而无需任何额外的修改。
 
     用处：
     一 提供默认的实现。
     二 为协议扩展添加限制条件
        如果一个遵循的类型满足了为同一方法或属性提供实现的多个限制型扩展的要求， Swift 会使用最匹配限制的实现。
 */
extension HasArea {
    func original() -> Double {
        return 888.0
    }
}


extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

class ProtocolController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objects: [AnyObject] = [
            Circle.init(radius: 2.0),
            Country.init(area: 243_610),
            BAnimal.init(legs: 4)
        ]
        
        for object in objects {
            if let obj = object as? HasArea {
                if let objjjj = obj as? Circle {
                    print("Area is \(objjjj.area). Original Area is \(objjjj.original())")
                }
                else {
//                    print("Area is \(obj.area). Original Area is \(obj.original())")
                }
            }
            else {
                print("Something that doesnot have an area")
            }
        }
    }

}

