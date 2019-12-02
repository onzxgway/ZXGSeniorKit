//
//  SandboxController.swift
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/2.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit


class SandboxController: UIViewController {

    /*
        Documents (iTunes同步设备时会备份该目录)
            ：保存应用运行时生成的需要持久化的数据（重要的、备份的）
     
        Library
            - 1.Caches
                ：保存应用运行时生成的需要持久化的数据（体积大、不重要、不备份）
     
            - 2.Preferences (iTunes同步设备时会备份该目录)
                ：保存应用的所有偏好设置
        tmp
            ：保存应用运行时所需要的临时数据或文件，使用完毕后再文件会从该目录删除。
                （例如断点下载）
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sandbox(沙盒)"
        
        print(NSHomeDirectory())
        
        documentMethod()
        
        library_caches_1()
        library_caches_2()
    }
    
    /*
        Documents
            :系统会自动备份该文件夹下面的所有文件。
        如果大文件（音视频，多媒体）放置在该文件夹下面的话，提交审核可能被拒接。
        解决办法： 必须对大文件做非备份设置
    */
    func documentMethod() {
        let tempPath = NSHomeDirectory() + "/Documents/"
        BackupTool.addSkipBackupAttributeToItem(at: URL.init(string: tempPath)!)
    }
    
    
    /*
        Library
        - 1.Caches
            :系统缓存存放的位置，一般存放体积大、不需要备份的非重要数据。
            
        系统不会清理 cache 目录中的文件，就要求程序开发时, "必须提供 cache 目录的清理解决方案"
    */
    // 网络请求的系统缓存会以db的形式存在Caches中
    func library_caches_1() {
        let urlStr = "http://svr.tuliu.com/center/front/app/util/updateVersions?versions_id=1&system_type=1"
        let request = URLRequest.init(url: URL.init(string: urlStr)!)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            print("net finish~~")
            if let innerdata = data {
                let infoDict = try! JSONSerialization.jsonObject(with: innerdata, options: .mutableLeaves)
                print(infoDict)
            }
        }
        task.resume()
    }
    
    
    /*
        Library
        - 2.Preferences
            :iTunes同步设备时会备份该目录，保存应用的所有偏好设置。
            
        UserDefault就是直接写在该目录下的，会以plist文件的形式保存。
        
    */
    // 网络请求的系统缓存会以db的形式存在Caches中
    func library_caches_2() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("kobe", forKey: "Key1")
        userDefaults.set("james", forKey: "Key2")
        userDefaults.synchronize() // 同步写入，不设置会异步写入
    }
    
    
    /*
        tmp
        保存应用运行时所需要的临时数据或文件，"后续不需要使用"，使用完毕后再将相应的文件从该目录删除。
        不定期清理：  1.重新启动手机, tmp 目录会被清空
                    2.系统磁盘空间不足时，系统也会自动清理，即使应用没有运行。
    */
    func tmp() {
        let userDefaults = UserDefaults.standard
        userDefaults.set("kobe", forKey: "Key1")
        userDefaults.set("james", forKey: "Key2")
        userDefaults.synchronize() // 同步写入，不设置会异步写入
    }
    

}
