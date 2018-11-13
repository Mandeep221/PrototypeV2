//
//  Multiplication.swift
//  
//
//  Created by Mandeep Sarangal on 2018-11-12.
//

import UIKit
import CoreData

class Multiplication: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Multiplication> {
        return NSFetchRequest<Multiplication>(entityName: "Multiplication")
    }
    
    @NSManaged var arrNumRows: [NSNumber]
    @NSManaged var arrNumColumns: [NSNumber] 
    
}
