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
    let topMargin:CGFloat = 20
    let bottomMargin:CGFloat = 20
    let leftMargin:CGFloat = 20
    let rightMargin:CGFloat = 20
    
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
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        topMarginForViews = navBarHeight! + statusBarHeight
        
        // MARK: creating UIView array and mapping them to a background color at the same time
        homeViews = backGroundColors.map({ (color) -> ModuleTypeContainerView in
            let view = ModuleTypeContainerView()
            view.accentBorderView.backgroundColor = color
            return view
        })
        
        if let topPaddingForAllViews = topMarginForViews, let moduleViews = homeViews{
            remainingTotalheight = view.frame.height - topPaddingForAllViews - topMargin - CGFloat(moduleViews.count) * bottomMargin
        }
        
        if let remainingTotalheight = remainingTotalheight, let homeViews = homeViews{
            for index in 0..<homeViews.count{
                view.addSubview(homeViews[index])
                homeViews[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
                
                homeViews[index].translatesAutoresizingMaskIntoConstraints = false
                
                let bottomAnchor = homeViews[index].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomMargin)
                bottomAnchor.isActive = false
                
                if index == 0 {
                    homeViews[index].anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: navBarHeight! + statusBarHeight + topMargin, left: leftMargin, bottom: bottomMargin, right: rightMargin), size: .init(width: 0, height: remainingTotalheight/5))
                }else{
                    
                    homeViews[index].anchor(top: homeViews[index - 1].bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topMargin, left: leftMargin, bottom: 0, right: rightMargin), size: .init(width: 0, height: remainingTotalheight/5))
                }
                
            }
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
            if let views = self.homeViews, self.tappedIndex != -1{
                let tappedView = views[self.tappedIndex]
                //tappedView.translatesAutoresizingMaskIntoConstraints = false
                self.tAnchor?.isActive = false
                if self.tappedIndex == 0{
                    tappedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.topMargin).isActive = true
                }else{
                    tappedView.topAnchor.constraint(equalTo: views[self.tappedIndex - 1].bottomAnchor, constant: self.topMargin).isActive = true
                }
                
                tappedView.heightAnchor.constraint(equalToConstant: self.remainingTotalheight!/5).isActive = true
               
                self.bAnchor?.isActive = false
                self.view.layoutIfNeeded()
            }
           
            
        
        }, completion: nil)
        
    }
    
    var bAnchor: NSLayoutConstraint?
    var tAnchor:NSLayoutConstraint?
    
    @objc func handleExpansion(gesture: UITapGestureRecognizer){
        
        if let v = gesture.view, let totalHeight = self.remainingTotalheight, let homeViews = self.homeViews{
            self.tappedIndex =  homeViews.index(of: v as! ModuleTypeContainerView)!
            
            tAnchor = v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.topMargin)
            tAnchor?.isActive = true
            bAnchor = v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -self.bottomMargin)
            bAnchor?.isActive = true
            
            self.view.bringSubview(toFront: v)
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()

                    for index in 0..<homeViews.count{
                        if index < self.tappedIndex{
                            // above master view
                            homeViews[index].transform = CGAffineTransform(translationX: 0, y: -totalHeight/5 * CGFloat(index + 1) - self.topMargin * CGFloat(index + 1))
                        }else if index > self.tappedIndex{
                            // below master view
                            let yValue = totalHeight/5 * CGFloat(homeViews.count - index) + CGFloat(homeViews.count - index) * self.topMargin
                            homeViews[index].transform = CGAffineTransform(translationX: 0, y: yValue)
                        }
                    }
                
            }, completion: { (_) in
                
            })


        }
    }

}
