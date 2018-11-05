//
//  LoveController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-02.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class LoveController: UIViewController {

    var leftConstraintForYou: NSLayoutConstraint?
    
    let wordContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // add views
        view.addSubview(wordContainerView)
        for index in 0..<letterCollection.count{
            wordContainerView.addSubview(letterCollection[index])
        }
        
        // constraints
        wordContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 272).isActive=true
        wordContainerView.heightAnchor.constraint(equalToConstant: 48).isActive=true
        
        for index in 0..<letterCollection.count{
            // constraints
            let widthConstant: CGFloat = 32
            if index == 0{
                letterCollection[index].leftAnchor.constraint(equalTo: wordContainerView.leftAnchor).isActive = true
//                widthConstant = 20
            }else{
                //widthConstant = 32
                var leftMargin: CGFloat = 0
                if index == 1 || index == 5{
                    leftMargin = 8
                    if index == 5{
                      leftConstraintForYou = letterCollection[index].leftAnchor.constraint(equalTo: letterCollection[index-1].rightAnchor, constant:leftMargin)
                        leftConstraintForYou?.isActive = true
                    }
                }

            letterCollection[index].leftAnchor.constraint(equalTo: letterCollection[index-1].rightAnchor, constant:leftMargin).isActive = true
            }
            
            letterCollection[index].topAnchor.constraint(equalTo: wordContainerView.topAnchor).isActive = true
            letterCollection[index].bottomAnchor.constraint(equalTo: wordContainerView.bottomAnchor).isActive = true
            letterCollection[index].widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
            letterCollection[index].heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        compressAnimation()
    }
    
    func compressAnimation() {
        self.leftConstraintForYou?.constant = 0
        self.view.layoutIfNeeded()
    }
}
