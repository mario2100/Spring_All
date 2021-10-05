//
//  ViewController.swift
//  CoreDataModelView
//
//  Created by vip on 17/3/28.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    var fecCon:NSFetchedResultsController<Student>?
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let modelUrl = Bundle.main.url(forResource: "StudentModel", withExtension: "momd")
        let mom = NSManagedObjectModel(contentsOf: modelUrl!)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("CoreDataExample.sqlite"))
        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: path, options: nil)
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        let request = NSFetchRequest<Student>(entityName: "Student")
        request.sortDescriptors = [NSSortDescriptor(key: "age", ascending: true)]
        fecCon = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fecCon?.delegate = self
        try! fecCon?.performFetch()
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellid")
        }
        let obj = fecCon?.object(at: indexPath)
        cell?.textLabel?.text = obj?.name
        cell?.detailTextLabel?.text = "年龄:\(obj?.age)"
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return fecCon!.sections!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fecCon!.sections![section].numberOfObjects
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let modelUrl = Bundle.main.url(forResource: "StudentModel", withExtension: "momd")
//        //创建数据模型
//        let mom = NSManagedObjectModel(contentsOf: modelUrl!)
//        //创建持久化存储协调者
//        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
//        //数据库保存路径
//        let path = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("CoreDataExample.sqlite"))
//        try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: path, options: nil)
//        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//        moc.persistentStoreCoordinator = psc
//        
//        let modelS = NSEntityDescription.insertNewObject(forEntityName: "Student", into: moc) as! Student
//        modelS.name = "张三"
//        modelS.age = 16
//        let modelS2 = NSEntityDescription.insertNewObject(forEntityName: "Student", into: moc) as! Student
//        modelS2.name = "李四"
//        modelS2.age = 17
//        try! moc.save()
//    }
    //数据将要改变时调用
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    //分区数据改变时调用的方法
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet.init(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.deleteSections(IndexSet.init(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    //数据改变时回调的代理
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [indexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tableView.reloadData()
        case .move:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
            self.tableView.insertRows(at: [indexPath!], with: .fade)
        }
    }
    //数据更新结束调用的代理
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}

