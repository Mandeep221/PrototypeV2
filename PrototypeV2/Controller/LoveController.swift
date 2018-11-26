//
//  LoveController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-02.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class LoveController: UIViewController {

    let xAxisDimensionContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .gray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
        
        let numColumnLabel = UILabel()
        numColumnLabel.numberOfLines = 1
        numColumnLabel.textColor = .white
        numColumnLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        numColumnLabel.textAlignment = .center
        numColumnLabel.text = "4"
        numColumnLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(numColumnLabel)
        containerView.addSubview(lineView)
        
        numColumnLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        numColumnLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        numColumnLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        numColumnLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lineView.topAnchor.constraint(equalTo: numColumnLabel.bottomAnchor, constant: 4).isActive = true
        lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        //lineView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return containerView
    }()
    
    lazy var letterCollection: [UILabel] = {
        var collection = [UILabel]()
        let letters: [String] = ["I", "L", "O", "V", "E", "Y", "O", "U"]
        for index in 0..<8{
            let letter = UILabel()
            letter.textColor = UIColor.init(rgb: Color.primaryPurple.rawValue, alpha: 1)
            letter.font = UIFont(name: "Montserrat-Regular", size: 32)
            letter.translatesAutoresizingMaskIntoConstraints = false
            letter.text = letters[index]
//            let randomNum = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//            letter.backgroundColor = UIColor(red: randomNum, green: randomNum, blue: randomNum, alpha: 1)
            letter.textAlignment = .center
            collection.append(letter)
        }
        
        return collection
    }()
    
    let arr: [CGFloat] = [100.0, 50.0, 150.0, 200.0, 250.0, 300.0]
    
    var tapCount = 0
    
    @objc func handleTap(){
        tapCount += 1
        
        if tapCount % 2 != 0{
            view.addSubview(xAxisDimensionContainerView)
            let width = arr.randomElement()!
            print("Width: ", width)
            xAxisDimensionContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
            xAxisDimensionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            //let width = numColumn * 20 + (numColumn - 1) * 6
            xAxisDimensionContainerView.widthAnchor.constraint(equalToConstant: width).isActive = true
            xAxisDimensionContainerView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        }else{
            print("Width: ", "Removed")
            xAxisDimensionContainerView.removeFromSuperview()
            //xAxisDimensionContainerView.clearConstraints()
        }
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
//        // add views
//        view.addSubview(wordContainerView)
//        for index in 0..<letterCollection.count{
//            wordContainerView.addSubview(letterCollection[index])
//        }
//
//        // constraints
//        wordContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        wordContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        wordContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 272).isActive=true
//        wordContainerView.heightAnchor.constraint(equalToConstant: 48).isActive=true
//
//        for index in 0..<letterCollection.count{
//            // constraints
//            let widthConstant: CGFloat = 32
//            if index == 0{
//                letterCollection[index].leftAnchor.constraint(equalTo: wordContainerView.leftAnchor).isActive = true
////                widthConstant = 20
//            }else{
//                //widthConstant = 32
//                var leftMargin: CGFloat = 0
//                if index == 1 || index == 5{
//                    leftMargin = 8
//                    if index == 5{
//                      leftConstraintForYou = letterCollection[index].leftAnchor.constraint(equalTo: letterCollection[index-1].rightAnchor, constant:leftMargin)
//                        leftConstraintForYou?.isActive = true
//                    }
//                }
//
//            letterCollection[index].leftAnchor.constraint(equalTo: letterCollection[index-1].rightAnchor, constant:leftMargin).isActive = true
//            }
//
//            letterCollection[index].topAnchor.constraint(equalTo: wordContainerView.topAnchor).isActive = true
//            letterCollection[index].bottomAnchor.constraint(equalTo: wordContainerView.bottomAnchor).isActive = true
//            letterCollection[index].widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
//            letterCollection[index].heightAnchor.constraint(equalToConstant: 40).isActive = true
//        }
//        compressAnimation()
    }
    
    func compressAnimation() {
        self.view.layoutIfNeeded()
    }
    
//    func clearConstraints(myView: UIView) {
//        for subview in myView.subviews {
//            subview.clearConstraints()
//        }
//        myView.removeConstraints(myView.constraints)
//    }
}
