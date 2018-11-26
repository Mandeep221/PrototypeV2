//
//  ContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

class ChildCellView: UIView {
    
    let cellWidth: CGFloat = 20
    let cellHeight: CGFloat = 20
    let cellInternalGap: CGFloat = 2
    var childCellImage: UIImage?
    
    func configureChildCell(cellChildCount: Int, childCellImage: UIImage) {
        self.childCellImage = childCellImage
        self.cellChildCount = cellChildCount
        setup()
    }
    var cellChildCount: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        for index in 0..<cellChildCount{
            let cell = UIImageView()
            //let image = UIImage(named: "icon_strawberry")
            cell.image = self.childCellImage
            cell.contentMode = .scaleAspectFill
            //b.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.init(rgb: 0xF6B691, alpha: 1).cgColor
            cell.layer.cornerRadius = cellHeight/2
            //cell.backgroundColor = UIColor.init(rgb: 0xF6B691, alpha: 1)
            cell.translatesAutoresizingMaskIntoConstraints = false
            
            //add views
            self.addSubview(cell)
            
            let leftMargin = cellWidth * CGFloat(index) + cellInternalGap * CGFloat(index)
            
            //constraints
            cell.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top:0 , left: leftMargin, bottom: 0, right: 0), size: .init(width: cellWidth, height:cellHeight))
        }
    }
    
}

class CellsContainerView: UIView {
    
    var cellWidth:CGFloat = 20
    let cellHeight:CGFloat = 20
    let cellGap:CGFloat = 6
    let containerHeight:CGFloat = 0
    let anchorHeight: CGFloat = 2
    var viewPracRef: PracticeController?
    var viewPracAdvRef: PracticeAdvanceController?
    var isLadySpeaking: Bool = false
    var cellChildCount = 1
    var toyImage: UIImage?
    // Maximum number of cells that can be swiped
    var swipableCellCount = 0
    
    // Number of cells that have been swiped at any given time
    var swipeCounter = 0 {
        didSet{
            if swipeCounter == swipableCellCount{
                if let viewPracRef = viewPracRef{
                    viewPracRef.updateTotalCellsSwiped(cellsSwiped: swipableCellCount)
                }
                
                if let viewPracAdvRef = viewPracAdvRef{
                    viewPracAdvRef.updateTotalCellsSwiped(cellsSwiped: swipableCellCount)
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
            //setUpCells()
        }
    }
    
    func setCellConfig(cellCount: Int, cellChildCount: Int, toyImage: UIImage) {
        self.cellCount = cellCount
        self.cellChildCount = cellChildCount
        self.toyImage = toyImage
        let childCell = ChildCellView()
        // cell width
        cellWidth = childCell.cellWidth * CGFloat(cellChildCount) + CGFloat(cellChildCount - 1) * CGFloat(childCell.cellInternalGap)
        setUpCells()
    }
    
    func setSwipableCells(count: Int) {
        swipableCellCount = count
        swipeCounter = 0
    }
    
    func setUpCells() {
        
       // if containerView not empty already, remove all cell views
        if !self.subviews.isEmpty{
            self.subviews.forEach { $0.removeFromSuperview() }
        }
        
        // start creating new cells
        //cellViews = [UIView]()
        cellViews = [UIView]()
        if let count = cellCount {
            for index in 0...count - 1 {

                let cellView = ChildCellView()
                cellView.configureChildCell(cellChildCount: self.cellChildCount, childCellImage: self.toyImage!)
                cellView.translatesAutoresizingMaskIntoConstraints = false
                
                // add right swipe gesture to the current cellView
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
                //swipeRight.direction = .right
                cellView.addGestureRecognizer(tapGesture)
                
                addSubview(cellView)

                 let leftMargin = index * Int(cellWidth + cellGap)
                
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(\(Int(cellWidth * CGFloat(cellChildCount) + CGFloat(cellChildCount - 1) * CGFloat(2))))]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : cellView]))
                
                //let containerHeight = self.frame.height
                var letLeftMargin = 0
                
                if containerHeight != cellHeight {
                    letLeftMargin = Int(containerHeight - cellHeight - ((containerHeight - cellHeight)/2))
                }
                
//                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(Int(letLeftMargin))-[v0(\(Int(cellHeight)))]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : cellView]))
                
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[v0(\(Int(cellHeight)))]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : cellView]))

                
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
        
        viewPracRef?.view.layer.addSublayer(rectLayer)
        
    }
    
    /*This method provides with an animation
     that shows which direction the objects need to be swiped */
    func handleSwipeDirectionHelp(){
        let numberOfCells = CGFloat((cellViews?.count)!)
        
        // slideCounter will change on every swipe, hence left margin value will also change
        let leftMargin = (numberOfCells * cellWidth) + (numberOfCells - 1 - CGFloat(swipeCounter)) * cellGap - cellWidth/2
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(24)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0(24)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        
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
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        if let view = gesture.view{
            
            let indexOfTappedView = cellViews!.index(of: view)
            if swipeCounter == swipableCellCount || swipeCounter == (cellViews?.count)! || indexOfTappedView != cellViews!.count - swipeCounter - 1 || isLadySpeaking {
                return
            }
            // assign a tag, use this tag to animate swiped cells
            view.tag = 2
            
            /*
             Only X-Cordinate is changing in animation
             Formula used to change X-Cordinate is :
             
             X-Cordinate = container_view.width - cell_width - (slideCounter * (cell_width + cellGap)
             */
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let x = self.frame.width - self.cellWidth - (CGFloat(self.swipeCounter) * (self.cellWidth + self.cellGap))
                
                
                view.frame = CGRect(x: x, y: view.frame.origin.y, width: self.cellWidth, height: self.cellHeight)
                self.swipeCounter += 1
                
                for subview in view.subviews {
                    // Manipulate the view
                    //subview.backgroundColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
                     subview.layer.borderColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1).cgColor
                }
                
            }, completion: nil)
            
        }else{
            print("View Nil")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .white
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
    
    func scaleSwipedCells(repeatCount: Float){
        let totalCells = cellViews!.count
        //let abc = totalCells - swipableCellCount
        
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 1.0
        pulse.toValue = 0.8
        pulse.repeatCount = repeatCount
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        pulse.autoreverses = true
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.7
        flash.repeatCount = repeatCount
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        flash.autoreverses = true
        
        for index in 0..<totalCells {
            // all tapped cells will have a tag = 2
            if cellViews?[index].tag == 2{
                cellViews?[index].layer.add(pulse, forKey: "scale")
                cellViews?[index].layer.add(flash, forKey: "flash")
            }
            
        }
    }
    
    func ladyDidFinishSpeaking() {
        isLadySpeaking = false
    }
}
