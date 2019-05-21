//
//  SaveData.swift
//  picture
//
//  Created by switch on 2019/4/26.
//  Copyright © 2019年 switch. All rights reserved.
//

import UIKit
import CoreData
class SaveData:NSObject{
    public func insertData(username:String,score:String)->Bool{
        var res = false
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName:"MaxScore" , into: context) as! MaxScore
        
        user.name = username
        user.time = score
        do {
            try context.save()
            res = true
            
        } catch  {
            fatalError("保存出错：\(error)")
        }
        return res
    }
    func findData()->[[String]]{
        var data=[["玩家名"],["使用时间"]]
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MaxScore>(entityName:"MaxScore")
        do {
            let fetchObjects = try context.fetch(fetchRequest)
            for info in fetchObjects{
                data[0].append(info.name!)
                data[1].append(info.time!)
            }
        } catch  {
            fatalError("查询出错：\(error)")
        }
        return data
    }
    func deleData()->Bool{
        var succe = false
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MaxScore>(entityName:"MaxScore")
        do {
            let fetchObjects = try context.fetch(fetchRequest)
            for info in fetchObjects{
                context.delete(info)
            }
        try! context.save()
        succe = true
        }catch{
            fatalError("删除时出现问题：\(error)")
        }
        return succe
    }
}
