//
//  HomeViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let expandingView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
        view.addSubview(expandingView)
        
        // MARK: Tap gesture events can't be set inside closures
        expandingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpansion)))
        
        expandingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        expandingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //expandingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        expandingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //expandingView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        expandingView.heightAnchor.constraint(equalToConstant: view.frame.height/5).isActive = true
    }
    
    @objc func handleLogout(){
        print("called")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandingView.transform = CGAffineTransform(scaleX: 1, y: 5)
        }, completion: nil)
        
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleExpansion(){
        print("called")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.expandingView.transform = CGAffineTransform(scaleX: 1, y: 5)
        }, completion: nil)
    }
    

}
