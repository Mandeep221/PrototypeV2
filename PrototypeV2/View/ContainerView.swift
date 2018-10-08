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
    
    var slideCounter = 0 {
        didSet{
            if slideCounter == 3{
                if let view = viewRef{
                  view.addPulsatingAnimation()
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
    
    let anchorBarView: UIView = {
        let anchor = UIView()
        anchor.translatesAutoresizingMaskIntoConstraints = false
        anchor.backgroundColor = .red
        return anchor
    }()
    
    let swipeDirectionArrowImageView: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(named: "hand")?.withRenderingMode(.alwaysTemplate)
        arrow.contentMode = .scaleAspectFill
        arrow.tintColor = .green
        return arrow
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
                
                // add right swipe gesture to the current cellView
                let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
                swipeRight.direction = .right
                cellView.addGestureRecognizer(swipeRight)

                
                addSubview(cellView)

                cellView.backgroundColor = .red
                let leftMargin = index * Int(cellWidth + cellGap)
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))

                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0(40)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : cellView]))
                cellViews?.append(cellView)
            }
        }
        
        // add hand image
        addSubview(swipeDirectionArrowImageView)
        handleHandGesture()
        //showPulsatingEffect()
    }
    let rectLayer = CAShapeLayer()
    var viewRef: ViewController?
    
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
        
        
        animateRectLayer()
    }
    
    func animateRectLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.3
        animation.duration = 3
        animation.autoreverses = true
        animation.repeatCount =  Float.infinity
        
        rectLayer.add(animation, forKey: "pulse")
    }
    
    func handleHandGesture(){
        let numberOfCells = CGFloat((cellViews?.count)!)
        
        // slideCounter will change on every swipe, hence left margin value will also change
        let leftMargin = (numberOfCells * cellWidth) + (numberOfCells - 1 - CGFloat(slideCounter)) * cellGap - cellWidth/2
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(leftMargin)-[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0(24)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : swipeDirectionArrowImageView]))
        
        
        let cellToSlide = cellViews![slideCounter]
        
        if (cellViews?.contains(cellToSlide))!{
            print(cellViews?.index(of: cellToSlide))
        }else{
            print("NOT FOUND")
        }
        
        UIView.animate(withDuration: 0.75, delay: 0, options: [.repeat], animations: {
            UIView.setAnimationRepeatCount(3)
            self.swipeDirectionArrowImageView.frame = CGRect(x: cellToSlide.frame.origin.x + 20 , y: self.swipeDirectionArrowImageView.frame.origin.y, width: self.swipeDirectionArrowImageView.frame.width, height: self.swipeDirectionArrowImageView.frame.height)
        }, completion: {(isCompleted) in
            UIView.animate(withDuration: 0.75, animations: {
                self.swipeDirectionArrowImageView.alpha = 0
            })
        })
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if let view = gesture.view {
            
            if slideCounter == (cellViews?.count)!{
                return
            }
            
            /*
             Only X-Cordinate is changing in animation
             Formula used to change X-Cordinate is :
             
             X-Cordinate = container_view.width - cell_width - (slideCounter * (cell_width + cellGap)
             */
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let x = self.frame.width - 40 - (CGFloat(self.slideCounter) * (self.cellWidth + self.cellGap))
                view.frame = CGRect(x: x, y: self.frame.height - 70, width: self.cellWidth, height: self.cellHeight)
                self.slideCounter += 1
                
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

}
