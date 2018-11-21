//
//  ModuleType.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-31.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation

enum ModuleType: String {
    case counting = "Counting"
    case addition = "Addition"
    case subtraction = "Subtraction"
    case multiplication = "Multiplication"
    case division = "Division"
    
     static let allValues = [counting, addition, subtraction, multiplication, division]
    
    static let allRawValues = [counting.rawValue, addition.rawValue, subtraction.rawValue, multiplication.rawValue, division.rawValue]
}
