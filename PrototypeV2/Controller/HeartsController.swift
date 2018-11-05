//
//  HeartsController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-02.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class HeartsController: UIViewController {

    let ineLabel: UILabel = {
       let label = UILabel()
        label.text = "Ine"
        label.textAlignment = .center
        label.textColor = UIColor.init(rgb: 0xEDEDC0, alpha: 1)
        label.font = UIFont(name: "TooFreakinCuteDemo", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let manuLabel: UILabel = {
        let label = UILabel()
        label.text = "manu"
        label.textAlignment = .center
        label.textColor = UIColor.init(rgb: 0xEDEDC0, alpha: 1)
        label.font = UIFont(name: "TooFreakinCuteDemo", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moonImageView: UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "sleeping_moon"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints=false
        return imageView
    }()
    
    let backGroundView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0xF8A8C4, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0x000000, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rigthBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0x1A1A1A, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backGroundView)
        
        view.addSubview(leftBackgroundView)
        view.addSubview(rigthBackgroundView)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.init(rgb: 0x000000, alpha: 1.0).cgColor, UIColor.init(rgb: 0x1a1a1a, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = view.frame
        //view.layer.addSublayer(gradientLayer)
        
        view.addSubview(ineLabel)
        view.addSubview(manuLabel)
        //view.addSubview(moonImageView)
        navigationController?.navigationBar.isHidden = true
        backGroundView.frame = view.frame
//        leftBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true
//        leftBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
//        leftBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
//        leftBackgroundView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
//
//        rigthBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true
//        rigthBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
//        rigthBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive=true
//        rigthBackgroundView.widthAnchor.constraint(equalToConstant: view.frame.width/2).isActive=true
        
        ineLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        ineLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ineLabel.heightAnchor.constraint(equalToConstant: 48)
        
        manuLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        manuLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        manuLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 48)
        manuLabel.heightAnchor.constraint(equalToConstant: 48)
        
//        moonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
//        moonImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -72).isActive = true
//        moonImageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
//        moonImageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
//
//
        startEmiting()
        
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }

    func startEmiting() {
        let ineEmitter = Emitter.getEmitter(with: #imageLiteral(resourceName: "heart_dark"), flag: "ine")
        ineEmitter.emitterPosition = CGPoint(x: 80, y: view.frame.height/2)
        ineEmitter.emitterSize = CGSize(width: 10, height: 10)
        view.layer.addSublayer(ineEmitter)

        let manuEmitter = Emitter.getEmitter(with: #imageLiteral(resourceName: "red_heart"), flag: "manu")
        manuEmitter.emitterPosition = CGPoint(x: view.frame.width - 110, y: view.frame.height/2)
        manuEmitter.emitterSize = CGSize(width: 10, height: 10)
        view.layer.addSublayer(manuEmitter)

    }
}
