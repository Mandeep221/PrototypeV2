//
//  ViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let squareView: UIView = {
        let sv = UIView()
        sv.backgroundColor = .red
        sv.frame = CGRect(x: 0, y: 100, width: 40, height: 40)
        return sv
    }()
    
    let sliderButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "feedback")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnClicked(sender: UIButton!) {
        //self.containerView.performSlide()
    }
    
    let containerViewOne: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        //cv.backgroundColor = .gray
        cv.cellCount = 7
        return cv
    }()
    
    let containerViewTwo: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        //cv.backgroundColor = .gray
        cv.cellCount = 7
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerViewOne.viewRef = self
        //containerView.showPulsatingEffect()
        
        view.backgroundColor = .white
        
        view.addSubview(containerViewOne)
        view.addSubview(containerViewTwo)
        
        //view.addSubview(sliderButton)
        
        // Horizontal constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : containerViewOne]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : containerViewTwo]))
        
        // Vertical constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0(100)]-40-[v1(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : containerViewOne, "v1": containerViewTwo]))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getX(slideCounter: Int) -> CGFloat{

        let leftMargin = containerViewOne.frame.width - containerViewOne.cellWidth - (CGFloat(slideCounter) * (containerViewOne.cellWidth + containerViewOne.cellGap))
        return leftMargin
    }
    
    func addPulsatingAnimation() {
        
        let trackLayer = CAShapeLayer()
                let targetCell = containerViewOne.cellViews![1]
                print(targetCell.frame.minY)
//
//                print(targetCell.frame.origin.x)
//                print(targetCell.frame.origin.y)
        
                let frame = CGRect(x: getX(slideCounter: 1) - 1 , y: targetCell.frame.minY - 1, width: containerViewOne.cellWidth + 2, height: containerViewOne.cellHeight + 2)
                let rectPAth = UIBezierPath(rect: frame)
        
                trackLayer.path = rectPAth.cgPath
        
                trackLayer.strokeColor = UIColor.green.cgColor
                trackLayer.lineWidth = 2
                trackLayer.fillColor = UIColor.clear.cgColor
        
                containerViewOne.layer.addSublayer(trackLayer)
        
                let animation = CABasicAnimation(keyPath: "opacity")
        
                animation.fromValue = 0.4
                animation.toValue = 1.0
                animation.duration = 1
                animation.autoreverses = true
                animation.repeatCount =  3
        
                trackLayer.add(animation, forKey: "pulse")
    }
}

