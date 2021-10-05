//
//  ViewController.swift
//  CoreDataTest
//
//  Created by vip on 17/3/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = Bundle.main.url(forResource: "StudentModel", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: url!)
        //创建持久化存储协调者
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model!)
        //数据库保存路径
        let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!.appending("CoreDataExample.sqlite"))
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: path, options: nil)
        //创建数据管理上下文
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        //关联持久化协调者
        moc.persistentStoreCoordinator = psc
        //创建班级数据对象
        let modelS = NSEntityDescription.insertNewObject(forEntityName: "SchoolClass", into: moc) as! SchoolClass
        modelS.name = "第一班"
        modelS.count = 60
        //创建学生数据对象
        let modelSt = NSEntityDescription.insertNewObject(forEntityName: "Student", into: moc) as! Student
        modelSt.name = "张三"
        modelSt.number = "14231233"
        modelS.monitor = modelSt
        //进行存储
        if (try? moc.save()) != nil {
            print("新增成功")
        }
        print(path.absoluteString)
        
        
        //创建一条查询请求
        let request = NSFetchRequest<SchoolClass>(entityName: "SchoolClass")
        //设置条件为count=60的数据
        request.predicate = NSPredicate(format: "count == %d", 60)
        //进行查询操作
        let res = try! moc.execute(request) as! NSAsynchronousFetchResult<SchoolClass>
        print(res.finalResult?.first?.name!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

