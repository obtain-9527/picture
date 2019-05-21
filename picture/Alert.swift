//
//  Alert.swift
//  picture
//
//  Created by switch on 2019/4/26.
//  Copyright © 2019年 switch. All rights reserved.
//

import UIKit
class Alert: NSObject {
    func alertView(s: UIViewController){
        let vcAlert = UIAlertController(title:"保存成功",message:"",preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK",style:.default,handler:nil)
        vcAlert.addAction(okAction)
        s.present(vcAlert,animated: true,completion: nil)
    }
}
