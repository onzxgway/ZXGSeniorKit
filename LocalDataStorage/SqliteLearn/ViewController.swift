//
//  ViewController.swift
//  SqliteLearn
//
//  Created by 朱献国 on 2019/12/9.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    var db:OpaquePointer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        openDB()
        
        print(NSHomeDirectory())
    }
    
    // 0.打开数据库 （没有的话，就创建）
    func openDB() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fullPath = path! + "/temp.sqlite3"
        let status = sqlite3_open_v2(fullPath, &db, SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX | SQLITE_OPEN_READWRITE, nil)
        if status != SQLITE_OK {
            print("sqlite3_open_v2 fail")
        } else {
            print("数据库打开成功！")
            closeDB()
        }
    }
    
    // 1.增删改
    
    // 2.查
    
    
    
    // 3.关闭数据库
    func closeDB() {
        
        let status = sqlite3_close_v2(db)
        if status == SQLITE_OK {
            print("数据库关闭成功！")
        } else {
            print("数据库关闭失败！")
        }
    }
}

