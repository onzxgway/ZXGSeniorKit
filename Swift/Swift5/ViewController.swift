//
//  ViewController.swift
//  Swift5
//
//  Created by 朱献国 on 2019/7/27.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let s = "I am chinese!"
        print(s)
        
        _ = #"The "rain" in "Spain" falls mainly on the Spaniards."#
        let keypaths = #"Swift keypaths such as \Person.name hold uninvoked references to properties."#
        let answer = "呜呜"
        let dontpanic = #"The answer to life, the universe, and everything is \#(answer)."#
        let str = ##"My dog said "woof"#gooddog"##
        let multiline = #"""
        The answer to life,
        the universe,
        and everything is \#(answer).
        """#
        print(multiline)
    }


}

