//
//  SplashController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-27.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class SplashController: UIViewController {
    
    var dotOneHeightAnchor: NSLayoutConstraint?
    var dotTwoHeightAnchor: NSLayoutConstraint?
    
    lazy var rotatingView: UIView = {
        let rotatingView = UIView()
        //rotatingView.backgroundColor = UIColor.init(rgb: Color.offWhite.rawValue, alpha: 0.4)
        rotatingView.translatesAutoresizingMaskIntoConstraints = false
        
        let viewMinus = UIView()
        viewMinus.layer.cornerRadius = 10
        viewMinus.backgroundColor = UIColor.init(rgb: Color.orange.rawValue, alpha: 0.6)
        viewMinus.translatesAutoresizingMaskIntoConstraints = false
        rotatingView.addSubview(viewMinus)
        
        let viewPlus = UIView()
        viewPlus.layer.cornerRadius = 10
        //viewPlus.backgroundColor = UIColor.init(rgb: Color.offWhite.rawValue, alpha: 0.6)
        viewPlus.translatesAutoresizingMaskIntoConstraints = false
        rotatingView.addSubview(viewPlus)
        
        let dotOneView = UIView()
        dotOneView.backgroundColor = UIColor.init(rgb: Color.red.rawValue, alpha: 0.6)
        dotOneView.translatesAutoresizingMaskIntoConstraints = false
        dotOneView.layer.cornerRadius = 10
        dotOneView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewPlus.addSubview(dotOneView)
        
        let dotTwoView = UIView()
        //dotTwoView.backgroundColor = UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 0.6)
        dotTwoView.backgroundColor = .green
        dotTwoView.translatesAutoresizingMaskIntoConstraints = false
        dotTwoView.layer.cornerRadius = 10
        dotTwoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viewPlus.addSubview(dotTwoView)
        
//        let viewMinus = UIView()
//        rotatingView.addSubview(viewMinus)
        
        // constraints
        viewMinus.centerXAnchor.constraint(equalTo: rotatingView.centerXAnchor).isActive = true
        viewMinus.centerYAnchor.constraint(equalTo: rotatingView.centerYAnchor).isActive = true
        viewMinus.widthAnchor.constraint(equalTo: rotatingView.widthAnchor).isActive = false
        viewMinus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        viewPlus.centerXAnchor.constraint(equalTo: rotatingView.centerXAnchor).isActive = true
        viewPlus.centerYAnchor.constraint(equalTo: rotatingView.centerYAnchor).isActive = true
        viewPlus.heightAnchor.constraint(equalTo: rotatingView.heightAnchor).isActive = false
        viewPlus.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        dotOneView.topAnchor.constraint(equalTo: viewPlus.topAnchor).isActive = true
        dotOneView.leadingAnchor.constraint(equalTo: viewPlus.leadingAnchor).isActive = true
        dotOneView.trailingAnchor.constraint(equalTo: viewPlus.trailingAnchor).isActive = true
        dotOneHeightAnchor = dotOneView.heightAnchor.constraint(equalTo: viewPlus.heightAnchor, multiplier: 1/2)
        dotOneHeightAnchor?.isActive = true
        
        dotTwoView.bottomAnchor.constraint(equalTo: viewPlus.bottomAnchor).isActive = true
        dotTwoView.leadingAnchor.constraint(equalTo: viewPlus.leadingAnchor).isActive = true
        dotTwoView.trailingAnchor.constraint(equalTo: viewPlus.trailingAnchor).isActive = true
        dotTwoHeightAnchor = dotTwoView.heightAnchor.constraint(equalTo: viewPlus.heightAnchor, multiplier: 1/2)
        dotTwoHeightAnchor?.isActive = true
        
        
        return rotatingView
    }()
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
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
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 1)
        
        view.addSubview(rotatingView)
        view.addSubview(appTitleLabel)
        view.addSubview(overlayView)
        
        rotatingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rotatingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        rotatingView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rotatingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        appTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appTitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        appTitleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        appTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 140).isActive = true
        
        //overlayView.frame = appTitleLabel.frame
        overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        overlayView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        overlayView.widthAnchor.constraint(equalTo: appTitleLabel.widthAnchor).isActive = true
        
        

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
        
//        animateAppTitle()
//        animateMinus()
//        animatePlus()
        
        UIView.animate(withDuration: 0.75, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            
            let newX = self.overlayView.frame.origin.x + self.overlayView.frame.width
            
            self.overlayView.frame = CGRect(x: newX, y: self.overlayView.frame.origin.y, width: 0, height: 48)
            
            //self.appTitleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: { (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.rotatingView.subviews.first?.widthAnchor.constraint(equalTo: self.rotatingView.widthAnchor).isActive = true
                self.view.layoutIfNeeded()
                    //self.rotatingView.subviews.first?.scale(fromValue: 0.05, toValue: 1.0)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.rotatingView.subviews[1].heightAnchor.constraint(equalTo: self.rotatingView.heightAnchor).isActive = true
                    self.view.layoutIfNeeded()
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.rotatingView.subviews.first?.transform = CGAffineTransform.init(rotationAngle: self.degreeToRadians(degrees: 45))
                        self.rotatingView.subviews[1].transform = CGAffineTransform.init(rotationAngle: self.degreeToRadians(degrees: 45))
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                            self.rotatingView.subviews.first?.transform = CGAffineTransform.init(rotationAngle: self.degreeToRadians(degrees: 180))
                            self.rotatingView.subviews[1].transform = CGAffineTransform.init(rotationAngle: self.degreeToRadians(degrees: 180))
                        }, completion: { (_) in
                            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                                self.dotOneHeightAnchor?.isActive = false
                                self.dotTwoHeightAnchor?.isActive = false
                                self.rotatingView.subviews[1].subviews[0].heightAnchor.constraint(equalToConstant: 20).isActive = true
                                self.rotatingView.subviews[1].subviews[1].heightAnchor.constraint(equalToConstant: 20).isActive = true
                                self.view.layoutIfNeeded()
                                self.rotatingView.subviews[1].subviews[0].layer.cornerRadius = 10
                                self.rotatingView.subviews[1].subviews[0].layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                                self.rotatingView.subviews[1].subviews[1].layer.cornerRadius = 10
                                 self.rotatingView.subviews[1].subviews[1].layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                            }, completion: { (_) in
                                
                            })
                        })
                    })
                })
            })
        })
    
    }
    
//    func animateAppTitle() {
//        UIView.animate(withDuration: 0.75, delay: 0.25, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
//
//            let newX = self.overlayView.frame.origin.x + self.overlayView.frame.width
//
//            self.overlayView.frame = CGRect(x: newX, y: self.overlayView.frame.origin.y, width: 0, height: 48)
//
//            //self.appTitleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        })
//        animateMinus()
//    }
//
//    func animateMinus() {
//        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.rotatingView.subviews.first?.widthAnchor.constraint(equalTo: self.rotatingView.widthAnchor).isActive = true
//            self.view.layoutIfNeeded()
//            //self.rotatingView.subviews.first?.scale(fromValue: 0.05, toValue: 1.0)
//        })
//        animatePlus()
//    }
//
//    func animatePlus() {
//        UIView.animate(withDuration: 1, delay: 3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.rotatingView.subviews[1].heightAnchor.constraint(equalTo: self.rotatingView.heightAnchor).isActive = true
//            self.view.layoutIfNeeded()
//        }, completion: { (_) in
//
//        })
//    }

    func degreeToRadians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }

}
