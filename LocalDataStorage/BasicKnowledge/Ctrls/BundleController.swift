//
//  BundleController.swift
//  BasicKnowledge
//
//  Created by 朱献国 on 2019/12/2.
//  Copyright © 2019 朱献国. All rights reserved.
//

import UIKit

class BundleController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Bundle"
        
        print(NSHomeDirectory())
        
        bundle()
    }

    /*
        1.bundle是用来放置资源文件的，不参与编译。
        2.一个App只有一个MainBundle,所有的自定义bundle都在MainBundle的目录下，作为其中的一个资源存在。
            大型项目需要使用多个bundle,每个模块对应一个。
     */
    func bundle() {
        let pathStr = Bundle.main.path(forResource: "Resource", ofType: "bundle")!
        let bundle = Bundle.init(path: pathStr)
        let imgStr = bundle?.path(forResource: "11", ofType: "png")
        imgView.image = UIImage.init(contentsOfFile: imgStr!)
    }

}
