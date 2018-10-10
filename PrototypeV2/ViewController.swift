//
//  ViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let anchorForContainerOne: UIView = {
        let abchorView = UIView()
        //abchorView.backgroundColor = UIColor.init(rgb: 0xF7CE3E)
        abchorView.backgroundColor = .yellow
        return abchorView
    }()
    
    let anchorForContainerTwo: UIView = {
        let abchorView = UIView()
        //abchorView.backgroundColor = UIColor.init(rgb: 0xF7CE3E)
        abchorView.backgroundColor = .yellow
        return abchorView
    }()
    
    
    let moduleSubTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.numberOfLines = 2
        subTitleLabel.textColor = UIColor.init(rgb: 0xF6B691, alpha: 1)
        subTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        subTitleLabel.text = "Lets learn"
        return subTitleLabel
    }()
    
    let moduleTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 32)
        titleLabel.text = "COUNTING"
        return titleLabel
    }()
    
    let instructionOneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Can you swipe two cells to the right?"
        return label
    }()
    
    let containerViewOne: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.cellCount = 7
        return cv
    }()
    
    let instructionTwoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Can you swipe two cells to the right?"
        return label
    }()
    
    let containerViewTwo: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.cellCount = 7
        return cv
    }()
    
    let optionOneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("12", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionTwoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("5", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionThreeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("9", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionFourButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("7", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var optionButton: [DesignableOptionView] = {
        var opt = [DesignableOptionView]()
        
        for index in 0...3 {
            let option = DesignableOptionView()
            option.isUserInteractionEnabled = true
            option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hand)))
            opt.append(option)
        }
        return opt
    }()
    
    @objc func hand(gesture: UITapGestureRecognizer) {
        let currentView = gesture.view as! DesignableOptionView
        if optionButton.contains(currentView){
            currentView.handleOptionClickAnimation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav bar
        navigationController?.navigationBar.isTranslucent = false
        
        edgesForExtendedLayout = []
        containerViewOne.viewRef = self
        
        //#2C163B
        view.backgroundColor = UIColor(rgb: 0x2C163B, alpha: 1)
        
        view.addSubview(moduleSubTitleLabel)
        view.addSubview(moduleTitleLabel)
        view.addSubview(instructionOneLabel)
        view.addSubview(anchorForContainerOne)
        view.addSubview(containerViewOne)
        view.addSubview(instructionTwoLabel)
        view.addSubview(anchorForContainerTwo)
        view.addSubview(containerViewTwo)
        view.addSubview(optionOneButton)
        view.addSubview(optionTwoButton)
        view.addSubview(optionThreeButton)
        view.addSubview(optionFourButton)
        for index in 0...optionButton.count - 1{
           view.addSubview(optionButton[index])
        }
        
        //Auto layout constraints
        moduleSubTitleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 20))
        
        moduleTitleLabel.anchor(top: moduleSubTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        instructionOneLabel.anchor(top: moduleTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        containerViewOne.anchor(top: instructionOneLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
        anchorForContainerOne.anchor(top: containerViewOne.topAnchor, leading: view.leadingAnchor, bottom: containerViewOne.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: 2))
        
        anchorForContainerTwo.anchor(top: containerViewTwo.topAnchor, leading: view.leadingAnchor, bottom: containerViewTwo.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: 2))
        
        instructionTwoLabel.anchor(top: containerViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        containerViewTwo.anchor(top: instructionTwoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        
        setConstraintsForOptions()
        
    }
    
    func setConstraintsForOptions() {
        let optionOneButton = optionButton[0]
        let optionTwoButton = optionButton[1]
        let optionThreeButton = optionButton[2]
        let optionFourButton = optionButton[3]
        
        //#TODO: width does not make sense, but somehow works
        optionThreeButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        // #TODO: width does not make sense, but somehow works
        optionFourButton.anchor(top: nil, leading: optionThreeButton.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionOneButton.anchor(top: nil, leading: view.leadingAnchor, bottom: optionThreeButton.topAnchor, trailing: nil, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionTwoButton.anchor(top: nil, leading: nil, bottom: optionFourButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
    }
    
    
    func getX(slideCounter: Int) -> CGFloat{
        
        let leftMargin = containerViewOne.frame.width - containerViewOne.cellWidth - (CGFloat(slideCounter) * (containerViewOne.cellWidth + containerViewOne.cellGap))
        return leftMargin
    }
    
    func addPulsatingAnimation() {
        
        let trackLayer = CAShapeLayer()
        let targetCell = containerViewOne.cellViews![1]
        print(targetCell.frame.minY)
        //
        //                print(targetCell.frame.origin.x)
        //                print(targetCell.frame.origin.y)
        
        let frame = CGRect(x: getX(slideCounter: 1) - 1 , y: targetCell.frame.minY - 1, width: containerViewOne.cellWidth + 2, height: containerViewOne.cellHeight + 2)
        let rectPAth = UIBezierPath(rect: frame)
        
        trackLayer.path = rectPAth.cgPath
        
        trackLayer.strokeColor = UIColor.green.cgColor
        trackLayer.lineWidth = 2
        trackLayer.fillColor = UIColor.clear.cgColor
        
        containerViewOne.layer.addSublayer(trackLayer)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0.4
        animation.toValue = 1.0
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount =  3
        
        trackLayer.add(animation, forKey: "pulse")
    }
}

