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
    
    static let moduleAccentColor: [UIColor] = [UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.orange.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.mudYellow.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.skyBlue.rawValue, alpha: 1),
                                        UIColor.init(rgb: Color.primary.rawValue, alpha: 1)]
    
    static let moduleImages: [UIImage] = [ UIImage(named: "icon_module_counting")!, UIImage(named: "icon_module_addition")!, UIImage(named: "icon_module_subtraction")!, UIImage(named: "icon_module_multiplication")!, UIImage(named: "icon_module_division")!]
    
    static let moduleNames: [ModuleType] = [.counting, .addition, .subtraction, .multiplication, .division]
    
    
    static func getModuleAt(index: Int) -> Module{
        let module = Module()
        module.name = moduleNames[index]
        module.accentColor = moduleAccentColor[index]
        module.image = moduleImages[index]
        return module
    }
}
