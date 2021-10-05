//
//  Student+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by vip on 16/10/27.
//  Copyright © 2016年 jaki. All rights reserved.
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student");
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?

}
