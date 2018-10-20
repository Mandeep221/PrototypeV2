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
    
    let cellWidth:CGFloat = 25
    let cellHeight:CGFloat = 25
    let cellGap:CGFloat = 6
    let containerHeight:CGFloat = 50
    var viewRef: ViewController?
    
    // Maximum number of cells that can be swiped
    var swipableCellCount = 0
    
    // Number of cells that have been swiped at any given time
    var swipeCounter = 0 {
        didSet{
            if swipeCounter == swipableCellCount{
                if let view = viewRef{
                    view.updateTotalCellsSwiped(cellsSwiped: swipableCellCount)
                }
            }
        }
    }
    
    let cellView: UIView = {
        let cell = UIView()
        cell.backgroundColor = .red
        cell.frame.size = CGSize(width: 40, height: 40)
        return cell
    }()
    
    let swipeDirectionArrowImageView: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(named: "hand")?.withRenderingMode(.alwaysTemplate)
        arrow.contentMode = .scaleAspectFill
        arrow.tintColor = .white
        arrow.alpha = 0
        return arrow
    }()
    
    var cellViews: [UIView]?
    
    var cellCount: Int? {
        didSet{
            // set up cells
            setUpCells()
        }
    }
    
    func setSwipableCells(count: Int) {
        swipableCellCount = count
    }
    
    func setUpCells() {
        
        cellViews?.append(cellView)
        // add cells
        cellViews = [UIView]()
        
        if let count = cellCount {
            for index in 0...count - 1 {

                let cellView = UIView()
                cellView.translatesAutoresizingMaskIntoConstraints = false
                
                // add right swipe gesture to the current cellView
                let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
                swipeRight.direction = .right
                cellView.addGestureRecognizer(swipeRight)

                
                addSubview(cellView)

                cellView.backgroundColor = UIColor.init(rgb: 0xF6B691, alpha: 1)
                let leftMargin = index * Int(cellWidth + cellGap)
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(\(Int(cellWidth)))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))
                //let containerHeight = self.frame.height
                let letLeftMargin = containerHeight - cellHeight - ((containerHeight - cellHeight)/2)
                
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(Int(letLeftMargin))-[v0(\(Int(cellHeight)))]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))
                cellViews?.append(cellView)
            }
        }
        
        // add hand image
        addSubview(swipeDirectionArrowImageView)
        //handleSwipeDirectionHelp()
        //showPulsatingEffect()
    }
    let rectLayer = CAShapeLayer()
    
    func showPulsatingEffect(){
        
        //let view = ViewController
        
         
         let targetCell = self
         let newRectPath = CGRect(x: targetCell.frame.origin.x - 10, y: targetCell.frame.origin.y - 10, width: targetCell.frame.width + 10, height: targetCell.frame.height + 10)
         let rectangularpath  = UIBezierPath(rect: newRectPath)
         rectLayer.path = rectangularpath.cgPath
        
        rectLayer.fillColor = UIColor.green.cgColor
        rectLayer.position = targetCell.center
        rectLayer.bounds = CGRect(x: targetCell.frame.origin.x - 4, y: targetCell.frame.origin.y - 4, width: targetCell.frame.width + 4, height: targetCell.frame.height + 4)
        
        viewRef?.view.layer.addSublayer(rectLayer)
        
    }
    
    /*This method provides with an animation
     that shows which direction the objects need to be swiped */
    func handleSwipeDirectionHelp(){
        let numberOfCells = CGFloat((cellViews?.count)!)
        
        // slideCounter will change on every swipe, hence left margin value will also change
        let leftMargin = (numberOfCells * cellWidth) + (numberOfCells - 1 - CGFloat(swipeCounter)) * cellGap - cellWidth/2
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        
        let cellToSlide = cellViews![swipeCounter]
        
        UIView.animate(withDuration: 0.75, delay: 1.5, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(2)
            self.swipeDirectionArrowImageView.alpha = 1.0
            self.swipeDirectionArrowImageView.frame = CGRect(x: cellToSlide.frame.origin.x + 20 , y: self.swipeDirectionArrowImageView.frame.origin.y, width: self.swipeDirectionArrowImageView.frame.width, height: self.swipeDirectionArrowImageView.frame.height)
        }, completion: {(isCompleted) in
            UIView.animate(withDuration: 0.75, animations: {
                self.swipeDirectionArrowImageView.alpha = 0
            })
        })
        
    }
    
    /*This method changes the position of the object that is swiped
     and also increses the count for number of objects that has been swiped*/
    @objc func handleSwipeGesture(gesture: UISwipeGestureRecognizer) {
        if let view = gesture.view {
            
            if swipeCounter == swipableCellCount || swipeCounter == (cellViews?.count)!{
                return
            }
            
            /*
             Only X-Cordinate is changing in animation
             Formula used to change X-Cordinate is :
             
             X-Cordinate = container_view.width - cell_width - (slideCounter * (cell_width + cellGap)
             */
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let x = self.frame.width - self.cellWidth - (CGFloat(self.swipeCounter) * (self.cellWidth + self.cellGap))
                
                
                view.frame = CGRect(x: x, y: view.frame.origin.y, width: self.cellWidth, height: self.cellHeight)
                self.swipeCounter += 1
                
                view.backgroundColor = UIColor.init(rgb: 0xED5169, alpha: 1)
                
            }, completion: nil)
            
        }else{
            print("View Nil")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateSwipedCells() {
         let indexToStartFrom = cellCount! - swipableCellCount
        UIView.setAnimationRepeatCount(5)
        
        for index in indexToStartFrom..<cellCount!{
            let view = self.cellViews![index]
            UIView.animate(withDuration: 1, animations: {
                view.alpha = 0.2
            }, completion: { (isCompleted) in
                view.alpha = 1.0
            })
        }
    }
}
