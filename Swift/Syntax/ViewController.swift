//
//  ViewController.swift
//  Syntax
//
//  Created by 朱献国 on 2019/8/5.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
        
    }()
    
    lazy var dataSource: [[String: String]] = {
        
        let dicArr = [
            ["The Basics": "BasicController"],
            ["Strings and Characters": "StringsAndCharactersController"],
            ["Collection Types": "CollectionTypeController"],
            ["Functions": "FunctionController"],
            ["Closures": "ClosureController"],
            ["Enumeration": "EnumerationController"],
            ["Structures and Classes": "StructAndClassController"],
            ["Properties": "PropertyController"],
            ["Methods": "MethodController"],
            ["Subscripts": "SubscriptController"],
            ["Inheritance": "InheritanceController"],
            ["Initialization": "InitController"],
            ["Deinitialization": "DeinitController"],
            ["Optional Chaining": "OptionalChainingController"],
            ["Error Handling": "ErrorHandlingController"],
            ["Type Casting": "TypeCastingController"],
            ["Nested Types": "NestedTypesController"],
            ["Extensions": "ExtensionController"],
            ["Protocols": "ProtocolController"],
            ["Generics": "GenericsController"],
            ["MemorySafety": "MemorySafetyController"],
        ]
        
        return dicArr
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Swift Syntax"
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }


}

// 向已有类型添加新功能
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let dic = dataSource[indexPath.row]
        cell.textLabel?.text = Array(dic.keys)[0]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = dataSource[indexPath.row]
        
        let clas: AnyClass
        // 由字符串转为类型的时候  如果类型是自定义的 需要在类型字符串前边加上你的项目的名字！
        let name = dic[Array(dic.keys)[0]] ?? ""
        if let cla = NSClassFromString("Syntax." + name) {
            clas = cla
        }
        else {
            clas = UIViewController.self
        }
        
        //        let cla: AnyClass = NSClassFromString(dic.values.first ?? "") ?? ClassAndStructController.self
        
        let ctrl = clas.alloc() as! UIViewController
//        name.startIndex
//        ctrl.navigationItem.title = name[..<(name.count - 10)]
        
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
}

