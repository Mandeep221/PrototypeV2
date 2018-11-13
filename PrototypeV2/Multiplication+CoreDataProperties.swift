//
//  Multiplication+CoreDataProperties.swift
//  
//
//  Created by Mandeep Sarangal on 2018-11-12.
//
//

import Foundation
import CoreData


extension Multiplication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Multiplication> {
        return NSFetchRequest<Multiplication>(entityName: "Multiplication")
    }

    @NSManaged public var arrayNumRows: NSObject?
    @NSManaged public var arrayNumColumns: NSObject?

}
