//
//  SchoolClass+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by vip on 16/10/27.
//  Copyright © 2016年 jaki. All rights reserved.
//

import Foundation
import CoreData
 

extension SchoolClass {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolClass> {
        return NSFetchRequest<SchoolClass>(entityName: "SchoolClass");
    }

    @NSManaged public var name: String?
    @NSManaged public var studentCount: Int16
    @NSManaged public var monitor: Student?

}
