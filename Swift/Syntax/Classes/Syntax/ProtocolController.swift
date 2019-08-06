//
//  ProtocolController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class ProtocolController: SyntaxBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK: - Protocols
/*
 
 */

protocol FirstProtocol {
    
}

protocol SecondProtocol {
    
}

// 遵循多个协议时，各协议之间用逗号（,）分隔：
struct Demo1: FirstProtocol, SecondProtocol {
    
}

class SupClass {
    
}

// 若一个拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
class DemoClass: SupClass, FirstProtocol, SecondProtocol {
    
}
