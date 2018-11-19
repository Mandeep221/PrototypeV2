//
//  HomeViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    fileprivate func setNavbar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        // search
        let timerImage = UIImage(named: "icon_timer")?.withRenderingMode(.alwaysTemplate)
        let progressButtonItem = UIBarButtonItem(image: timerImage, style: .plain, target: self, action: #selector(launchProgressController))
        navigationItem.rightBarButtonItem = progressButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        setNavbar()
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        topMarginForViews = navBarHeight! + statusBarHeight

        // MARK: map module data
        homeViews = [ModuleTypeContainerView]()
        for index in 0..<5 {
            let module = ModuleDataInjector.getModuleAt(index: index)
            let view = ModuleTypeContainerView()
            view.viewRef = self
            view.module = module
            
            homeViews?.append(view)
        }
        
        // MARK: Constraints
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
                    homeViews[index].anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topMargin, left: leftMargin, bottom: bottomMargin, right: rightMargin), size: .init(width: 0, height: remainingTotalheight/5))
                }else{
                    
                    homeViews[index].anchor(top: homeViews[index - 1].bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topMargin, left: leftMargin, bottom: 0, right: rightMargin), size: .init(width: 0, height: remainingTotalheight/5))
                }
                
            }
        }
    }
    
    @objc func launchProgressController() {
        let vc = ProgressController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleLogout() {
        if let _ = Auth.auth().currentUser{
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
//            let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
//            kAppDelegate.showLoginViewController()
            let nextVc = LoginController()
            navigationController?.pushViewController(nextVc, animated: true)
            print("Logged out")
        }else{
            let nextVc = LoginController()
            navigationController?.pushViewController(nextVc, animated: true)
            print("User was not logged in")
        }
    }
    
    func handleCancelModule(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            if let homeViews = self.homeViews{
                for index in 0..<homeViews.count{
                    homeViews[index].transform = .identity
                }
            }
            
            // shrink the expanded view
            if let views = self.homeViews, self.tappedIndex != -1{
                let tappedView = views[self.tappedIndex] as! ModuleTypeContainerView
                tappedView.showCancelOption(show: false)
                tappedView.handleOptionsContainerVisiblity(visible: false)
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
        self.tappedIndex =  -1
    }
    
    func launchModule(level: Int, moduleType: ModuleType, toyImage: UIImage) {
        
        if moduleType == ModuleType.multiplication{
            let nextVc = PracticeAdvanceController()
            nextVc.toyImage = toyImage
            nextVc.level = level
            nextVc.moduleType = moduleType
            navigationController?.pushViewController(nextVc, animated: true)
        }else{
            let nextVc = PracticeController()
            nextVc.moduleType = moduleType
            nextVc.toyImage = toyImage
            nextVc.level = level
            navigationController?.pushViewController(nextVc, animated: true)
        }
        
         //MARK: Launch the real deal
//        if let tappedView = gesture.view as! ModuleTypeContainerView?{
//            let moduleName = tappedView.module?.name
//            if moduleName == ModuleType.multiplication{
//                let nextVc = PracticeAdvanceController()
//                nextVc.moduleType = tappedView.module?.name
//                navigationController?.pushViewController(nextVc, animated: true)
//            }else{
//                let nextVc = PracticeController()
//                nextVc.moduleType = tappedView.module?.name
//                navigationController?.pushViewController(nextVc, animated: true)
//            }
//        }
    }
    
    var bAnchor: NSLayoutConstraint?
    var tAnchor:NSLayoutConstraint?
    
    @objc func handleExpansion(gesture: UITapGestureRecognizer){
        
        // If user taps again on the expanded Module container
        if(self.tappedIndex == homeViews?.index(of: gesture.view!)){
            return
        }
        
        if let v = gesture.view as! ModuleTypeContainerView?, let totalHeight = self.remainingTotalheight, let homeViews = self.homeViews{
            //v.handleOptionsContainerVisiblity(visible: true)
            self.tappedIndex =  homeViews.index(of: v)!
            tAnchor = v.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.topMargin)
            tAnchor?.isActive = true
            bAnchor = v.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -self.bottomMargin)
            bAnchor?.isActive = true
            
            self.view.bringSubviewToFront(v)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
                
                v.showCancelOption(show: true)
                
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
