//
//  ContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

class ContainerView: UIView {
    
    let cellWidth:CGFloat = 40
    let cellHeight:CGFloat = 40
    let cellGap:CGFloat = 8
    var slideCounter = 0
    
    let cellView: UIView = {
        let cell = UIView()
        cell.backgroundColor = .red
        cell.frame.size = CGSize(width: 40, height: 40)
        return cell
    }()
    
    let anchorBarView: UIView = {
        let anchor = UIView()
        anchor.translatesAutoresizingMaskIntoConstraints = false
        anchor.backgroundColor = .red
        return anchor
    }()
    
    var cellViews: [UIView]?
    
    var cellCount: Int? {
        didSet{
            // set up cells
            setUpCells()
        }
    }
    
    func setUpCells() {
        
        // add the anchor bar
         addSubview(anchorBarView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : anchorBarView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-48-[v0(4)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : anchorBarView]))
        
        
        cellViews?.append(cellView)
        // add cells
        cellViews = [UIView]()
        
        if let count = cellCount {
            for index in 0...count - 1 {

                let cellView = UIView()
                cellView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(cellView)

                cellView.backgroundColor = .red
                let leftMargin = index * Int(cellWidth + cellGap)
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))

                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))
                cellViews?.append(cellView)
            }
        }
    }
    
    func performSlide() {
        
        // if all the cells are already on the right side, Do nothing
        if slideCounter == (cellViews?.count)!{
            return
        }
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        
            if let cellSize = self.cellViews?.count{
                let cellIndex = cellSize - 1 - self.slideCounter
                let cellToSlide = self.cellViews![cellIndex]
                
                /*
                Only X-Cordinate is changing in animation
                Formula used to change X-Cordinate is :
                 
                X-Cordinate = container_view.width - cell_width - (slideCounter * (cell_width + cellGap)
                */
                
                let x = self.frame.width - 40 - (CGFloat(self.slideCounter) * (self.cellWidth + self.cellGap))
                cellToSlide.frame = CGRect(x: x, y: self.frame.height - 70, width: self.cellWidth, height: self.cellHeight)
                self.slideCounter += 1
            }

        }, completion: nil)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
