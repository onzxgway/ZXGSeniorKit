//
//  StringsAndCharactersController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/9/16.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/*
    字符串和字符
        字符串是一系列字符的集合。
 
    1.字符串字面量
    2.初始化空字符串
    3.字符串可变性
    4.字符串是值类型
    5.使用字符
    6.连接字符串和字符
 */

// MARK: - 1.字符串字面量
/*
    字符串字面量是由一对双引号包裹着的具有固定顺序的字符集。
        1.多行字符串字面量
        2.字符串字面量的特殊字符
        3.扩展字符串分隔符
 */
func one() {
    let someString = "Some string literal value"
    print(someString)
    
    // 1.多行字符串字面量
    /*
        这个字符从开启引号（"""）之后的第一行开始，到关闭引号（"""）之前为止。
        这就意味着字符串开启引号之后（"""）或者结束引号（"""）之前都没有换行符号。
     */
    let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."

-----
"""
    print(quotation)
    
    let singleLineString = "These are the same."
    let multilineString = """
These are the same.
"""
    if singleLineString == multilineString {
        print("singleLineString == multilineString")
    }
    
    // 如果你想换行，以便加强代码的可读性，但是你又不想在你的多行字符串字面量中出现换行符的话，你可以用在行尾写一个反斜杠（\）作为续行符。
    let softWrappedQuotation = """
    The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
    print(softWrappedQuotation)
    
    // 一个多行字符串字面量能够缩进来匹配周围的代码。关闭引号（"""）之前的空白字符串告诉 Swift 编译器其他各行多少空白字符串需要忽略
    let linesWithIndentation = """
    this line doesnot begin with whitespace.
        this line begin with four spaces.
    this line doesnot begin with whitespace.
    """
    print(linesWithIndentation)
}

func two() {
    // 2.字符串字面量的特殊字符
    /*
     字符串字面量可以包含以下特殊字符：
     转义字符 \0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
     Unicode 标量，写成 \u{n}(u 为小写)，其中 n 为任意一到八位十六进制数且可用的 Unicode 位码。
     */
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein" // （\）转义字符
    print(wiseWords)
    // "Imageination is more important than knowledge" - Enistein
    let dollarSign = "\u{24}"             // $，Unicode 标量 U+0024
    print(dollarSign)
    let blackHeart = "\u{2665}"           // ♥，Unicode 标量 U+2665
    print(blackHeart)
    let sparklingHeart = "\u{1F496}"      // 💖，Unicode 标量 U+1F496
    print(sparklingHeart)
    let threeDoubleQuotes = """
Escaping the first quote \"""
Escaping all three quotes \"\"\"
"""
    print(threeDoubleQuotes)
}

func three() {
    // 3.扩展字符串分隔符
    let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
    print(threeMoreDoubleQuotationMarks)
    
}

// MARK: - 2.初始化空字符串
/*
    你可以通过检查 Bool 类型的 isEmpty 属性来判断该字符串是否为空
 */
func four() {
    let emptyString = ""               // 空字符串字面量
    let anotherEmptyString = String()  // 初始化方法
    // 两个字符串均为空并等价。
    
    if emptyString.isEmpty, anotherEmptyString.isEmpty {
        print("Nothing to see here")
    }
    // 打印输出：“Nothing to see here”
}

// MARK: - 3.字符串可变性
func five() {
    var variableString = "Horse"
    variableString += " and carriage"
    // variableString 现在为 "Horse and carriage"
    
//    let constantString = "Highlander"
//    constantString += " and another Highlander"
    // 这会报告一个编译错误（compile-time error） - 常量字符串不可以被修改。
}


// MARK: - 4.字符串是值类型
/*
    在 Swift 中 String 类型是值类型。
 */

// MARK: - 5.使用字符
func six() {
    let t = "Dog!🐶"
    // 获取每一个字符
    for character in t {
        print(character)
    }
    
    let chars: [Character] = ["D", "o", "g", "!", "🐶"]
    let catString = String.init(chars)
    print(catString)
}

// MARK: - 6.连接字符串和字符
/*
    你不能将一个字符串或者字符添加到一个已经存在的字符变量上，因为字符变量只能包含一个字符。
 */
func seven() {
    // 字符串可以通过加法运算符（+）相加在一起（或称“连接”）创建一个新的字符串
    let string1 = "hello"
    let string2 = " there"
    var welcome = string1 + string2
    // welcome 现在等于 "hello there"
    print(welcome)
    
    // 你也可以通过加法赋值运算符（+=）将一个字符串添加到一个已经存在字符串变量上
    var instruction = "look over"
    instruction += string2
    // instruction 现在等于 "look over there"
    print(instruction)
    
    let exclamationMark: Character = "!"
    welcome.append(exclamationMark)
    // welcome 现在等于 "hello there!"
    print(welcome)
    
    // 多行字符串字面量来拼接字符串
    let badStart = """
one
two
"""
    let end = """
three
"""
    print(badStart + end)
    
    let goodStart = """
one
two

"""
    print(goodStart + end)
    // 上面的代码，把 badStart 和 end 拼接起来的字符串非我们想要的结果。因为 badStart 最后一行没有换行符，它与 end 的第一行结合到了一起。相反的，goodStart 的每一行都以换行符结尾，所以它与 end 拼接的字符串总共有三行，正如我们期望的那样。
}

class StringsAndCharactersController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        one()
//        two()
//        three()
//        four()
//        five()
//        six()
        seven()
    }
}
