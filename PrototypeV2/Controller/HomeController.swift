//
//  HomeViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    var tappedIndex = -1
    var topMarginForViews: CGFloat?
    var remainingTotalheight: CGFloat?
    var homeViews: [UIView]?
    var backGroundColors: [UIColor] = [UIColor.init(rgb: Color.red.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.orange.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.offWhite.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.skyBlue.rawValue, alpha: 1),
                                       UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
                                       ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
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
    }
    
    override func viewDidLayoutSubviews() {
        for index in 0..<homeViews!.count{
            print("expandingView \(index): ",homeViews![index].frame.height)
        }
    }
    
    @objc func handleLogout(){
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            if let homeViews = self.homeViews{
                for index in 0..<homeViews.count{
                    homeViews[index].transform = .identity
                }
            }
            
            // shrink the expanded view
            if let totalHeight = self.remainingTotalheight, let views = self.homeViews, self.tappedIndex != -1{
                let unitHeight = totalHeight/5
                let originY = self.view.frame.height - (CGFloat(views.count - self.tappedIndex) * unitHeight)
                let tappedView = views[self.tappedIndex]
                self.view.layoutIfNeeded()
                tappedView.frame = CGRect(x: 0, y: originY, width: self.view.frame.width, height: unitHeight)
                
            }
           
        
        }, completion: nil)
        
    }
    
    @objc func handleExpansion(gesture: UITapGestureRecognizer){
        let frame = CGRect(x: 0, y: topMarginForViews!, width: view.frame.width, height: view.frame.height - topMarginForViews!)
        
        if let v = gesture.view{
            self.view.bringSubview(toFront: v)
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                
                if let totalHeight = self.remainingTotalheight, let homeViews = self.homeViews{
                    v.frame = frame
                    self.tappedIndex =  homeViews.index(of: v)!
                    for index in 0..<homeViews.count{
                        if index < self.tappedIndex{
                            // above master view
                            homeViews[index].transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * CGFloat(index + 1))
                        }else if index > self.tappedIndex{
                            // below master view
                            let yValue = totalHeight/5 * CGFloat(homeViews.count - index)
                            homeViews[index].transform = CGAffineTransform(translationX: 0, y: yValue)
                        }
                    }
                }
            }, completion: { (_) in
                
            })


        }
    }

}
