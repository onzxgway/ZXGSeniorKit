//
//  AccessControlController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/10/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    访问控制 access control
        可以明确的给单个类型（class、struct、enum、protocol）设置访问级别，也可以给这些类型的属性、方法、构造器和下标等设置访问级别。
 
        1.模块和源文件
        2.访问级别
        3.自定义类型
        4.子类
        5.常量、变量、属性、下标
        6.构造器
        7.协议
        8.Extension
        9.泛型
 */

// MARK: - 1.模块和源文件
/*
 Swift中的访问控制是 基于模块（module）和源文件（source file）概念的。
 
 Swift中一个target（例如框架或者应用程序）就是一个独立的模块。当框架被导入到应用程序中或者其他框架时，框架内容都将属于这个独立的模块。
 
 源文件就是Swift中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。
 */


// MARK: - 2.访问级别
/*
 1.Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。
 2.Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
 3.File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
 4.Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。
 
 Open 只能作用于类和类的成员，它和 Public 的区别如下：
 
     Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
     Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
 
     Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
     Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写。
 */

/*
    访问级别基本原则
        Swift 中的访问级别遵循一个基本原则：实体不能定义在具有更低访问级别（更严格）的实体中。
        例如： 一个 Public 的变量，其类型的访问级别不能是 Internal，File-private 或是 Private。因为无法保证变量的类型在使用变量的地方也具有访问权限。
    函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
 
    默认访问级别
        默认为 internal 级别
 
    单 target 应用程序的访问级别
        使用默认的访问级别 Internal 即可。但是，你也可以使用 fileprivate 访问或 private 访问级别，用于隐藏一些功能的实现细节。
 
    框架的访问级别
        当开发框架需要把一些对外的接口定义为 Open 或 Public，以便使用者导入该框架后可以正常使用其功能。这些被你定义为对外的接口，就是这个框架的 API。
 
    单元测试 target 的访问级别
        当你的应用程序包含单元测试 target 时，为了测试，测试模块需要访问应用程序模块中的代码。默认情况下只有 open 或 public 级别的实体才可以被其他模块访问。然而，如果在导入应用程序模块的语句前使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，单元测试目标就可以访问应用程序模块中所有内部级别的实体。
 */

// MARK: - 3.自定义类型
public class SomePublicClass {                  // 显式 public 类
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

class SomeInternalClass {                       // 隐式 internal 类
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

fileprivate class SomeFilePrivateClass {        // 显式 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

private class SomePrivateClass {                // 显式 private 类
    func somePrivateMethod() {}                  // 隐式 private 类成员
}

// 元组类型
/*
    元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal，另一个类型为 private，那么这个元组的访问级别为 private。
    元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
 */
class TupleType {
    private let tempT: (SomeFilePrivateClass, SomePrivateClass) = (SomeFilePrivateClass.init(), SomePrivateClass.init())
    
    func tupleType() {
        let t = TupleType.init()
        print(t.tempT)
    }
}

//func tupleType() {
//    let t = TupleType.init()
//    print(t.tempT)
//}

// 函数类型
/*
    函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
 */

// 枚举类型
/*
    枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
 
    原始值和关联值
    枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 的枚举中定义 private 的原始值类型。
 */

// 嵌套类型
/*
    如果在 private 的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
 */


// MARK: - 4.子类
/*
    子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
 */
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        super.someMethod() // 因为父类 A 和子类 B 定义在同一个源文件中，所以在子类 B 可以在重写的 someMethod() 方法中调用 super.someMethod()。
    }
}


// MARK: - 5.常量、变量、属性、下标
/*
    常亮、变量和属性不能拥有比它们类型更高的访问权限。下标不能拥有比索引类型和返回类型更高的访问权限。
 */
// Getter 和 Setter
func ttt() {
    var stringToEdit = TrackedString()
    stringToEdit.value = "This string will be tracked."
    stringToEdit.value += " This edit will increment numberOfEdits."
    stringToEdit.value += " So will this one."
    print("The number of edits is \(stringToEdit.numberOfEdits)")
    // 打印“The number of edits is 3”
}

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

public struct TrackedString2 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

// MARK: - 6.构造器
/*
    自定义构造器的访问级别可以低于等于所在类型的访问级别。
    必要构造器的访问级别必须和所属类型的访问级别相同。
    默认构造器的访问级别与所属类型的访问级别相同，除非类型的访问级别是 public。如果一个类型被指定为 public 级别，那么默认构造器的访问级别将为 internal。如果你希望一个 public 级别的类型也能在其他模块中使用这种无参数的默认构造器，你只能自己提供一个 public 访问级别的无参数构造器。
    成员逐一构造器，如果结构体中任意存储型属性的访问级别为 private，那么该结构体默认的成员逐一构造器的访问级别就是 private。否则，这种构造器的访问级别依然是 internal。如同前面提到的默认构造器，如果你希望一个 public 级别的结构体也能在其他模块中使用其默认的成员逐一构造器，你依然只能自己提供一个 public 访问级别的成员逐一构造器。
 
 */

// MARK: - 7.协议
/*
    如果想为一个协议类型明确地指定访问级别，在定义协议时指定即可。这将限制该协议只能在适当的访问级别范围内被遵循。 协议中的每一个要求都具有和该协议相同的访问级别。你不能将协议中的要求设置为其他访问级别。这样才能确保该协议的所有要求对于任意遵循者都将可用。
 
    注意:
        如果你定义了一个 public 访问级别的协议，那么该协议的所有实现也会是 public 访问级别。这一点不同于其他类型，例如，当类型是 public 访问级别时，其成员的访问级别却只是 internal。
 
    协议继承:
    如果定义了一个继承自其他协议的新协议，那么新协议拥有的访问级别最高也只能和被继承协议的访问级别相同。例如，你不能将继承自 internal 协议的新协议定义为 public 协议。
 
    协议遵循:
        一个类型可以遵循比它级别更低的协议。例如，你可以定义一个 public 级别类型，它能在别的模块中使用，但是如果它遵循一个 internal 协议，这个遵循的部分就只能在这个 internal 协议所在的模块中使用。
 
    遵循协议时的上下文级别是类型和协议中级别最小的那个。如果一个类型是 public 级别，但它要遵循的协议是 internal 级别，那么这个类型对该协议的遵循上下文就是 internal 级别。
 
    当你编写或扩展一个类型让它遵循一个协议时，你必须确保该类型对协议的每一个要求的实现，至少与遵循协议的上下文级别一致。例如，一个 public 类型遵循一个 internal 协议，这个类型对协议的所有实现至少都应是 internal 级别的。
 
 */

// MARK: - 8.Extension 的私有成员

// MARK: - 9.泛型
// 泛型类型或泛型函数的访问级别取决于泛型类型或泛型函数本身的访问级别，还需结合类型参数的类型约束的访问级别，根据这些访问级别中的最低访问级别来确定。

// MARK: - 10.类型别名
/*
  你定义的任何类型别名都会被当作不同的类型，以便于进行访问控制。类型别名的访问级别不可高于其表示的类型的访问级别。
 
      例如，private 级别的类型别名可以作为 private、file-private、internal、public 或者 open 类型的别名，但是 public 级别的类型别名只能作为 public 类型的别名，不能作为 internal、file-private 或 private 类型的别名。
 */

class AccessControlController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        tupleType()
        TupleType.init().tupleType()
    }

}
