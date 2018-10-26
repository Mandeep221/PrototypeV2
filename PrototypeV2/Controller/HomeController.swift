//
//  HomeViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

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
    
        view.addSubview(expandingViewOne)
        view.addSubview(expandingViewTwo)
        view.addSubview(expandingViewThree)
        view.addSubview(expandingViewFour)
        view.addSubview(expandingViewFive)
        
        // MARK: Tap gesture events can't be set inside closures
        expandingViewOne.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        expandingViewTwo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        expandingViewThree.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        expandingViewFour.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        expandingViewFive.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        
        let totalheight = view.frame.height
        //let totalheight = view.frame.height
        
        //print("safe area height: ", totalheightSafe)
        print("Total height: ", totalheight)
        
        let heightOfEachView = view.frame.height / 5
        
        print(totalheight, heightOfEachView)
        
        expandingViewOne.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: totalheight/5))
        
        expandingViewTwo.anchor(top: expandingViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: totalheight/5))
        
        expandingViewThree.anchor(top: expandingViewTwo.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: totalheight/5))
        
        expandingViewFour.anchor(top: expandingViewThree.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: totalheight/5))
        
        expandingViewFive.anchor(top: expandingViewFour.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: totalheight/5))
    }
    
    @objc func handleLogout(){
        print("called")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandingViewOne.transform = CGAffineTransform(scaleX: 1, y: 5)
        }, completion: nil)
        
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleExpansion(gesture: UITapGestureRecognizer){
        
        if let v = gesture.view{
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                v.transform = CGAffineTransform(scaleX: 1, y: 5)
            }, completion: nil)
            
            view.bringSubview(toFront: v)
//            if view == expandingViewOne{
//
//            }else if
        }
        
        print("called")
        
    }
    

}
