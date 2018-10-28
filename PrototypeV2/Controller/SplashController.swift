//
//  SplashController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-27.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class SplashController: UIViewController {
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.textAlignment = .center
        label.text = "Math For Kids"
        //label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overlayView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(rgb: Color.red.rawValue, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 1)
        
        view.addSubview(appTitleLabel)
        view.addSubview(overlayView)
        
        appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appTitleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        appTitleLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        //overlayView.frame = appTitleLabel.frame
        overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        overlayView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        overlayView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        

//        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
//
//            let newX = self.overlayView.frame.origin.x + self.overlayView.frame.width
//
//                self.overlayView.frame = CGRect(x: newX, y: self.overlayView.frame.origin.y, width: 20, height: 48)
//        }, completion: nil)
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//
//
//
////            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
////
////            }
//        }
    }
    
    override func viewDidLayoutSubviews() {
        print(self.overlayView.frame.origin.x)
        print(self.overlayView.frame.origin.y)
        
        UIView.animate(withDuration: 0.75, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            
            let newX = self.overlayView.frame.origin.x + self.overlayView.frame.width
            
            self.overlayView.frame = CGRect(x: newX, y: self.overlayView.frame.origin.y, width: 0, height: 48)
        }, completion: nil)
    }

}
