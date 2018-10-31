//
//  ModuleDataInjector.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-31.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

class ModuleDataInjector{
    
    static let moduleAccentColor: [UIColor] = [UIColor.init(rgb: Color.red.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.orange.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.offWhite.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.skyBlue.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.primary.rawValue, alpha: 1)]
    
    static let moduleImages: [UIImage] = [#imageLiteral(resourceName: "add_icon"), #imageLiteral(resourceName: "add_icon"), #imageLiteral(resourceName: "subtract_icon"), #imageLiteral(resourceName: "add_icon"), #imageLiteral(resourceName: "add_icon")]
    
    static let moduleNames: [ModuleType] = [.counting, .addition, .subtraction, .multiplication, .division]
    
    
    static func getModuleAt(index: Int) -> Module{
        let module = Module()
        module.name = moduleNames[index]
        module.accentColor = moduleAccentColor[index]
        module.image = moduleImages[index]
        return module
    }
}
