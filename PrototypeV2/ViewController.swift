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
       // btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.titleLabel?.text = "Slide"
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc func btnClicked(sender: UIButton!) {
        self.containerView.performSlide()
    }
    
    let containerView: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .gray
        cv.cellCount = 3
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        
        view.addSubview(sliderButton)
        
//        view.addConstraint(NSLayoutConstraint(item: sliderButton, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 20))
//
//        view.addConstraint(NSLayoutConstraint(item: sliderButton, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        

        // Horizontal constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : containerView]))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : sliderButton]))
        
        // Vertical constraint
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[v0(100)]-20-[v1(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : containerView, "v1" : sliderButton]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

