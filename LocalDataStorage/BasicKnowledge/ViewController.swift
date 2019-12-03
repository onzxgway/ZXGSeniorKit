//
//  ViewController.swift
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/1.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var dataSourceArys: [String] = {
        var ary = [String]()
        
        ary.append("OverView");
        ary.append("SandBox");
        ary.append("Bundle");
        ary.append("KeyChain");
        ary.append("KeyedArchiver");
        
        return ary
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }

    func initSubviews() {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        view.addSubview(tableView)
        tableView.frame = view.bounds;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = dataSourceArys[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var value = dataSourceArys[indexPath.row]
        value.append("Controller")

//        if let classType = NSClassFromString(value) as? UIViewController.Type {
//            let ctrl = classType.init()
//            navigationController?.pushViewController(ctrl, animated: true)
//        }
        
        if indexPath.row == 0 {
            let deskVC = storyboard!.instantiateViewController(withIdentifier: "OverViewController") as! OverViewController
            navigationController?.pushViewController(deskVC, animated: true)
        } else if indexPath.row == 1 {
            let deskVC = SandboxController.init()
            navigationController?.pushViewController(deskVC, animated: true)
        } else if indexPath.row == 2 {
            let deskVC = BundleController.init()
            navigationController?.pushViewController(deskVC, animated: true)
        } else if indexPath.row == 3 {
           let deskVC = KeyChainController.init()
           navigationController?.pushViewController(deskVC, animated: true)
        }
        
    }
    
}

