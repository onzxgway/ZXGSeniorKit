//
//  FiveNewFeatureController.swift
//  Swift5
//
//  Created by 朱献国 on 2019/7/28.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

/**
 swift5新特性:
    1.新增了原始字符串。
 */

class FiveNewFeatureController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rawStrings()
    }
    
    // 原始字符串：所有的字符都直接按照字面的意思来使用，没有转义、特殊或不能打印的字符。
    /**
     优点：正则表达式将特别受益。
     使用方式：在字符串前放置一个或多个#符号
     */
    func rawStrings() -> Void {
        let rain = #"The "rain" in "Spain" falls mainly on the Spaniards."#
        print(rain)
        let keypaths = #"Swift keypaths such as \n hold uninvoked references to properties."#
        print(keypaths)
        // 在一个原始字符串中发生字符串插值时，必须添加额外的#。
        let answer = 42
        let dontpanic = #"The answer to life, the universe, and everything is \#(answer)."#
        print(dontpanic)
        // #"是一个整体，作为原始字符串的开头，向后寻找"#，找到即视为原始字符串终止。
        let str = ##"My dog said "woof"#gooddog"##
        print(str)
        let str_1 = ###"My dog said "woof"##gooddog"###
        print(str_1)
        // 多行字符串
        let multiline = #"""
        The answer to life,
        the universe,
        and everything is \#(answer).
        """#
        print(multiline)
    }

}
