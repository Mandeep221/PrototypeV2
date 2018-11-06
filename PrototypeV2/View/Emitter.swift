//
//  Emitter.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-02.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class Emitter {
    
    static func getEmitter(with image: UIImage, flag: String) -> CAEmitterLayer{
        let emitter = CAEmitterLayer()
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterCells = generateEmitterCells(with: image, flag: flag)
        return emitter
    }
    
    static func generateEmitterCells(with image: UIImage, flag: String) -> [CAEmitterCell]{
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 2
        cell.lifetime = 10
        cell.velocity = 60
        if flag == "ine"{
            cell.emissionLongitude = (90 * (.pi/180))
        }else{
            cell.emissionLongitude = (270 * (.pi/180))
        }
        cell.emissionRange = (80 * (.pi)/180)
        cell.scale = 0.2
        cell.scaleRange = 0.1
        
        cells.append(cell)
        return cells
    }
}
