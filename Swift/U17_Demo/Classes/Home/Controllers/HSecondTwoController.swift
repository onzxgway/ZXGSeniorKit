//
//  HSecondBaseController.swift
//  U17_Demo
//
//  Created by 朱献国 on 2019/8/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class HSecondTwoController: HSecondViewController {
    
    // MARK: - 属性的类型
    /**
     1.存储型属性: 用于存储一个常量或者变量。（在内存中实实在在开辟了存储空间的）
     
     2.计算型属性: 不直接存储值，而是通过setter、getter方法来取值、赋值，可以操作其他属性的变化。
        * 不能直接赋值。
        * 注意死循环。
     
     二者比较：
     * 计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
     * 计算属性必须使用var修饰，因为计算型属性的值是会变化的，存储属性var和let都可以。
     
     如何区分？
     有setter或者getter方法的就是计算属性(willSet和didSet不算)，否则是存储属性。
     */
    
    // 1.存储型属性
    private var firstName: String = "beyond"
    private var lastName: String = "kobe"
    
    // 2.计算型属性
    private var fullName: String {
        // 定义计算属性的setter方法(默认名称newValue)
        set(newValue) {
            firstName = newValue.components(separatedBy: " ").first!
            lastName = newValue.components(separatedBy: " ").last!
        }
        // 定义计算属性的getter方法，该方法的返回值由firstName、lastName两个存储属性决定
        get {
            return firstName + " " + lastName
        }
    }
    
    private var name: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    internal var height: String {
        return "185"
    }
    
    // 计算型属性，这种写法会导致死循环。
    //    private var age: Int {
    //        set(newValue) {
    //            age = newValue
    //        }
    //        get {
    //            return age
    //        }
    //    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 访问父类private修饰的属性
//        self.desc = "baba!"
//        self.content = "dudu"
        
        temp()
    }
    
    
    // MARK: - 属性观察器
    /**
        相当于OC中的KVO机制。
     
        注意事项：
            * 在构造方法内赋值或者在 声明时候赋值默认值，都是不调用willSet和didSet方法的。
            * 即使设置的值和原来值相同，willSet和didSet也会被调用。
     */
    internal var address: String = "abc" {
        // 属性即将进行改变时调用
        willSet(newValue) { // 参数名可以自定义
            print(newValue)// 系统的临时变量，用来保存即将要赋的值
        }
        // 属性已经改变后调用
        didSet(oldValue) {  // 参数名可以自定义
            print(oldValue)// 系统的临时变量，用来保存属性改变前的值
        }
    }
    
    
    // MARK: - 可选类型
    internal var opStr: String? = "haha"
    internal var upStr: String?
    internal var downStr: String! = "wuwu"
    
    func temp() {
        // 1.手动强制解包
//        print(opStr!) // 当你确定自定义的可选类型一定有值时，可以使用操作符(!)进行强制解析
//        print(upStr!) // 可选值为nil时使用(!)进行强制解析，会有运行错误。
        
        // 2.自动解包
//        print(downStr)
        
        // 3.可选绑定
        /**
            可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量。
            if let 和 guard 两种用法，意思相反。
         */
        
        if let temp = opStr {
            print(temp)
        }
        
        guard upStr != nil else {
            print("no value!")
            return
        }
    }
    
    
    override func clicked() {
        let ctrl = HSecondThreeController.init()
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

