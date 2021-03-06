//
//  Module.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-31.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

class Module{
    var name: ModuleType?
    var accentColor: UIColor?
    var image: UIImage?
    
    let images: [UIImage] = [
        UIImage(named: "icon_strawberry")!,
        UIImage(named: "icon_snake")!,
        UIImage(named: "icon_rainbow")!,
        UIImage(named: "icon_butterfly")!
    ]
    
    let toyNames: [String] = [
        "strawberry",
        "snake",
        "rainbow",
        "butterfly"
    ]
    
    func getToyName(image: UIImage) -> String {
        var found = ""
        for i in 0..<images.count{
            if images[i].isEqualToImage(image: image){
                found = toyNames[i]
                break
            }
        }
        return found
    }
}
