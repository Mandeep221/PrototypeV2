//
//  NumberData+CoreDataProperties.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-12.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//
//

import Foundation
import CoreData


extension NumberData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NumberData> {
        return NSFetchRequest<NumberData>(entityName: "NumberData")
    }

    @NSManaged public var arrNumRows: [NSNumber]
    @NSManaged public var arrNumColumns: [NSNumber]

}
