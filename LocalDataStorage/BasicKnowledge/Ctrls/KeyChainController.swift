//
//  KeyChainController.swift
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/3.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit
import Security

class KeyChainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "KeyChain(钥匙串)"
        
        print(NSHomeDirectory())
        
        saveDataToKeyChain()
    }
    
    /*
        KeyChain是系统级的，一旦存入数据，除非手动删除，否则不论应用卸载与否，信息都会存在。
        且可跨应用查询。
     */

    /*
     增
    */
    func saveDataToKeyChain() {
        var attr = [CFString:Any]()
        // 数据类型 key (kSecClass)
        /*
         kSecClassInternetPassword  // 互联网密码
         kSecClassGenericPassword   // 通用密码
         kSecClassCertificate       // 证书
         kSecClassKey               // 密钥
         kSecClassIdentity          // 身份ID
         */
        attr[kSecClass] = kSecClassGenericPassword
        /*
         kSecAttrServer     // 服务id
         kSecAttrGeneric    // 标示符
         kSecAttrAccount    // 账户
        */
        attr[kSecAttrAccount] = "KeyChain"
        attr[kSecValueData] = "123456".utf8
        let status = SecItemAdd(attr as CFDictionary, nil)
        if status == noErr {
            print("Success!")
        } else {
            print("error:\(status)")
        }
    }
    
    /*
     删
    */
    func deleteArchData() {
        var attr = [CFString:Any]()
        // 数据类型 key (kSecClass)
        /*
         kSecClassInternetPassword  // 互联网密码
         kSecClassGenericPassword   // 通用密码
         kSecClassCertificate       // 证书
         kSecClassKey               // 密钥
         kSecClassIdentity          // 身份ID
         */
        attr[kSecClass] = kSecClassGenericPassword
        /*
         kSecAttrServer     // 服务id
         kSecAttrGeneric    // 标示符
         kSecAttrAccount    // 账户
        */
        attr[kSecAttrAccount] = "KeyChain"
        attr[kSecReturnData] = kCFBooleanTrue
        
        let status = SecItemDelete(attr as CFDictionary)
        if status == noErr {
            print("Success!")
        } else {
            print("error:\(status)")
        }
    }
    
    /*
     改
    */
    func updateArchData() {
        var attr = [CFString:Any]()
        // 数据类型 key (kSecClass)
        /*
         kSecClassInternetPassword  // 互联网密码
         kSecClassGenericPassword   // 通用密码
         kSecClassCertificate       // 证书
         kSecClassKey               // 密钥
         kSecClassIdentity          // 身份ID
         */
        attr[kSecClass] = kSecClassGenericPassword
        /*
         kSecAttrServer     // 服务id
         kSecAttrGeneric    // 标示符
         kSecAttrAccount    // 账户
        */
        attr[kSecAttrAccount] = "KeyChain"
        
        var newAttr = [CFString:Any]()
        newAttr[kSecValueData] = "123456".utf8
        
        let status = SecItemUpdate(attr as CFDictionary, newAttr as CFDictionary)
        if status == noErr {
            print("Success!")
        } else {
            print("error:\(status)")
        }
    }
    
    /*
     查
    */
    func selectArchData() {
        var attr = [CFString:Any]()
        // 数据类型 key (kSecClass)
        /*
         kSecClassInternetPassword  // 互联网密码
         kSecClassGenericPassword   // 通用密码
         kSecClassCertificate       // 证书
         kSecClassKey               // 密钥
         kSecClassIdentity          // 身份ID
         */
        attr[kSecClass] = kSecClassGenericPassword
        /*
         kSecAttrServer     // 服务id
         kSecAttrGeneric    // 标示符
         kSecAttrAccount    // 账户
        */
        attr[kSecAttrAccount] = "KeyChain"
        attr[kSecReturnData] = kCFBooleanTrue
        
        let data: CFData? = nil
        let status = SecItemCopyMatching(attr as CFDictionary, data as? UnsafeMutablePointer<CFTypeRef?>)
        if status == noErr {
            print("Success!")
            print("\(data! as Data)")
        } else {
            print("error:\(status)")
        }
    }

}
