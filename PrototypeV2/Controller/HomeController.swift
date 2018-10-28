//
//  HomeViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var topMarginForViews: CGFloat?
    var remainingTotalheight: CGFloat?
    var homeViews: [UIView]?
    var backGroundColors: [UIColor] = [UIColor.init(rgb: Color.red.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.orange.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.offWhite.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.skyBlue.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
                                       ]
    
//    let homeViews: [UIView] = {
//
//        var views = [UIView]()
//        for index in 0..<5 {
//            let view = UIView()
//            views.append(view)
//        }
//        return views
//
//
//    }()
    
    let dummy: UIView = {
       let du = UIView()
        du.backgroundColor = UIColor.init(rgb: Color.orange.rawValue, alpha: 1)
        return du
    }()
    
    let expandingViewOne: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0xFF0000, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let expandingViewTwo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0xFF7C00, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let expandingViewThree: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0xEBE8E8, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let expandingViewFour: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0x90C1EC, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let expandingViewFive: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
//        view.addSubview(dummy)
//
//        let frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
//        dummy.frame = frame
//
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        topMarginForViews = navBarHeight! + statusBarHeight
        remainingTotalheight = view.frame.height - topMarginForViews!
        
        // MARK: creating UIView array and mapping them to a background color at the same time
        homeViews = backGroundColors.map({ (color) -> UIView in
            let view = UIView()
            view.backgroundColor = color
            return view
        })
        
        if let remainingTotalheight = remainingTotalheight, let homeViews = homeViews{
            for index in 0..<homeViews.count{
                view.addSubview(homeViews[index])
                homeViews[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
                
                if index == 0 {
                    homeViews[index].anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: navBarHeight! + statusBarHeight, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
                }else{
                    homeViews[index].anchor(top: homeViews[index - 1].bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
                }
                
            }
        }
        
//        view.addSubview(expandingViewOne)
//        view.addSubview(expandingViewTwo)
//        view.addSubview(expandingViewThree)
//        view.addSubview(expandingViewFour)
//        view.addSubview(expandingViewFive)
        
        // MARK: Tap gesture events can't be set inside closures
//        expandingViewOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
//        expandingViewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
//        expandingViewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
//        expandingViewFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
//        expandingViewFive.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))

//        let navBarHeight = self.navigationController?.navigationBar.frame.height
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        topMarginForViews = navBarHeight! + statusBarHeight
//        remainingTotalheight = view.frame.height - topMarginForViews!

//        if let remainingTotalheight = remainingTotalheight{
//            expandingViewOne.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: navBarHeight! + statusBarHeight, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
//
//            expandingViewTwo.anchor(top: expandingViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
//
//            expandingViewThree.anchor(top: expandingViewTwo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
//
//            expandingViewFour.anchor(top: expandingViewThree.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
//
//            expandingViewFive.anchor(top: expandingViewFour.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: remainingTotalheight/5))
//        }
    
    }
    
    override func viewDidLayoutSubviews() {
        for index in 0..<homeViews!.count{
            print("expandingView \(index): ",homeViews![index].frame.height)
        }
    }
    
    @objc func handleLogout(){
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
            if let homeViews = self.homeViews{
                for index in 0..<homeViews.count{
                    homeViews[index].transform = .identity
                }
            }
        
        }, completion: nil)
        
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleExpansion(gesture: UITapGestureRecognizer){
        //let frame = CGRect(x: 0, y: topMarginForViews!, width: view.frame.width, height: view.frame.height - topMarginForViews!)
        if let v = gesture.view{
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
                if let totalHeight = self.remainingTotalheight, let homeViews = self.homeViews{
                    let viewCount = homeViews.count
                    
                    // MARK: Implementation 1
                    v.transform = CGAffineTransform(scaleX: 1, y: 5)
                    homeViews[0].transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * 1)
                    homeViews[1].transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * 2)
                    homeViews[3].transform = CGAffineTransform(translationX: 0, y: totalHeight/5 * 2)
                    homeViews[4].transform = CGAffineTransform(translationX: 0, y: totalHeight/5 * 1)
                    
                    // MARK: Vs
                    
                    
                    // MARK: Implementation 2
                    for index in 0..<viewCount{
                        if v == homeViews[index]{
                            v.transform = CGAffineTransform(scaleX: 1, y: 5)
                            //v.frame = frame
                            self.view.bringSubview(toFront: v)
                        }else{
                            // calculate multiplier of height based on index value
                            if index < viewCount/2{
                                homeViews[index].transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * CGFloat(index + 1))
                            }else{
                                homeViews[index].transform = CGAffineTransform(translationX: 0, y: totalHeight/5 * CGFloat(viewCount - index + 1))
                            }
                        }
                    }
                    
                    
                    
//                    self.expandingViewOne.transform = self.expandingViewOne.transform.translatedBy(x: 0, y: -totalHeight/5 * 1)
//                    self.expandingViewTwo.transform = self.expandingViewOne.transform.translatedBy(x: 0, y: -totalHeight/5 * 2)
//                    self.expandingViewFour.transform = self.expandingViewOne.transform.translatedBy(x: 0, y: totalHeight/5 * 2)
//                    self.expandingViewFive.transform = self.expandingViewOne.transform.translatedBy(x: 0, y: totalHeight/5 * 1)
//
//                    self.expandingViewOne.transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * 1)
//                    self.expandingViewTwo.transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * 2)
//                    self.expandingViewFour.transform = CGAffineTransform(translationX: 0, y: totalHeight/5 * 2)
//                    self.expandingViewFive.transform = CGAffineTransform(translationX: 0, y: totalHeight/5 * 1)
//                    //self.expandingViewOne.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//                    //self.expandingViewTwo.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                     //self.expandingViewFour.transform = CGAffineTransform(scaleX: 1, y: 0.1)
//                    //self.expandingViewFive.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                    
                    

                }
            }, completion: nil)
            
            //view.bringSubview(toFront: v)
//            if view == expandingViewOne{
//
//            }else if
        }
        
        print("called")
        
    }
    

}
