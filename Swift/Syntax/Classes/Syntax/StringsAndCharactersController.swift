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
    7.字符串插值
    8.Unicode
    9.计算字符数量
    10.访问和修改字符串
    11.子字符串
    12.比较字符串
    13.字符串的 Unicode 表示形式
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

 // MARK: - 7.字符串插值
func eight() {
    let multiplier = 3
    let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
    // message 是 "3 times 2.5 is 7.5"
    print(message)
}

 // MARK: - 8.Unicode
func nine() {
    
}

 // MARK: - 9.计算字符数量
func ten() {
    let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
    print("unusualMenagerie has \(unusualMenagerie.count) characters")
    // 打印输出“unusualMenagerie has 40 characters”
}

 // MARK: - 10.访问和修改字符串
/*
    1.你可以使用 startIndex 和 endIndex 属性或者 index(before:) 、index(after:) 和 index(_:offsetBy:) 方法在任意一个确认的并遵循 Collection 协议的类型里面，如上文所示是使用在 String 中，你也可以使用在 Array、Dictionary 和 Set 中。
 
    2.你可以使用 insert(_:at:)、insert(contentsOf:at:)、remove(at:) 和 removeSubrange(_:) 方法在任意一个确认的并遵循 RangeReplaceableCollection 协议的类型里面，如上文所示是使用在 String 中，你也可以使用在 Array、Dictionary 和 Set 中。
 */
func eleven() {
    // 字符串索引
    /*
     1.Swift的字符串不能用整数（integer）做索引。 前面提到，不同的字符可能会占用不同数量的内存空间，所以要知道 Character 的确定位置，就必须从 String 开头遍历每一个 Unicode 标量直到结尾。因此，Swift 的字符串不能用整数（integer）做索引。
     
     2.每一个 String 值都有一个关联的索引（index）类型，String.Index，它对应着字符串中的每一个 Character 的位置。
     
     3.使用 startIndex 属性可以获取一个 String 的第一个 Character 的索引。使用 endIndex 属性可以获取最后一个 Character 的后一个位置的索引。因此，endIndex 属性不能作为一个字符串的有效下标。如果 String 是空串，startIndex 和 endIndex 是相等的。
     通过调用 String 的 index(before:) 或 index(after:) 方法，可以立即得到前面或后面的一个索引。你还可以通过调用 index(_:offsetBy:) 方法来获取对应偏移量的索引，这种方式可以避免多次调用 index(before:) 或 index(after:) 方法。
     */
    let greeting = "Guten Tag!"
    
    print(greeting[greeting.startIndex])
    // G
    print(greeting[greeting.index(before: greeting.endIndex)])
    // !
    print(greeting[greeting.index(after: greeting.startIndex)])
    // u
    let index = greeting.index(greeting.startIndex, offsetBy: 7)
    print(greeting[index])
    // a
    
    // 使用 indices 属性会创建一个包含全部索引的范围（Range），用来在一个字符串中访问单个字符。
    for index in greeting.indices {
        print("\(greeting[index]) ", terminator: "")
    }
    // 打印输出“G u t e n   T a g ! ”
    
    
    // 插入和删除
    var welcome = "hello"
    welcome.insert("!", at: welcome.endIndex) // 插入字符
    // welcome 变量现在等于 "hello!"
    
    welcome.insert(contentsOf:" there", at: welcome.index(before: welcome.endIndex)) // 插入字符串
    // welcome 变量现在等于 "hello there!"
    
    welcome.remove(at: welcome.index(before: welcome.endIndex))
    // welcome 现在等于 "hello there"
    
    let range = welcome.index(welcome.endIndex, offsetBy: -6) ..< welcome.endIndex
    welcome.removeSubrange(range)
    // welcome 现在等于 "hello"
}

 // MARK: - 11.子字符串
/*
    当你从字符串中获取一个子字符串 —— 例如，使用下标或者 prefix(_:) 之类的方法 —— 就可以得到一个 SubString 的实例，而非另外一个 String。
    Swift 里的 SubString 绝大部分函数都跟 String 一样，意味着你可以使用同样的方式去操作 SubString 和 String。然而，跟 String 不同的是，你只有在短时间内需要操作字符串时，才会使用 SubString。当你需要长时间保存结果时，就把 SubString 转化为 String 的实例。
 */
func twelve() {
    let greeting = "Heollo, world!"
    print(greeting.prefix(6))
    let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
//    let index = greeting.lastIndex(of: "o") ?? greeting.endIndex
    let beginning = greeting[..<index]
    print(greeting.prefix(upTo: index))
    print(greeting.suffix(from: index))
    print(String.init(beginning))
    
    /*
        就像 String，每一个 SubString 都会在内存里保存字符集。而 String 和 SubString 的区别在于性能优化上，SubString 可以重用原 String 的内存空间，或者另一个 SubString 的内存空间（String 也有同样的优化，但如果两个 String 共享内存的话，它们就会相等）。这一优化意味着你在修改 String 和 SubString 之前都不需要消耗性能去复制内存。就像前面说的那样，SubString 不适合长期存储 —— 因为它重用了原 String 的内存空间，原 String 的内存空间必须保留直到它的 SubString 不再被使用为止。
     */

}

// MARK: - 12.比较字符串
/*
    Swift 提供了三种方式来比较文本值：字符串字符相等、前缀相等和后缀相等。
 */
func thirdteen() {
    
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
//        seven()
//        eight()
//        nine()
//        ten()
//        eleven()
//        twelve()
        thirdteen()
    }
}
