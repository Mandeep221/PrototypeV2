//
//  DesignableOptionView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-10.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

class DesignableOptionView: UIView{
    
    let numberOptionLabel: UILabel = {
        let label = UILabel()
        //label.textColor = UIColor.init(rgb: 0x2C163B, alpha: 1)
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.textAlignment = .center
        label.text = "34"
        return label
    }()
    
    let textOptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xF6B691, alpha: 1)
        //label.textColor = UIColor.init(rgb: 0x908FAA, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textAlignment = .center
        label.text = "text"
        return label
    }()
    
    func setUpViews(){
        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.init(rgb: 0xF6B691, alpha: 1).cgColor
        //self.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        self.backgroundColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.1)
        
        addSubview(numberOptionLabel)
        addSubview(textOptionLabel)
        
        // add Auto layout constraints
        numberOptionLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0))
        
        textOptionLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: 0, height: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleOptionClickAnimation(isCorrect: Bool){
        if isCorrect{
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundColor = UIColor.init(rgb: 0x41B3A3, alpha: 1)
            }, completion: nil)
        }else{
            self.shake()
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundColor = UIColor.init(rgb: 0xED5169, alpha: 0.6)
            }) { (true) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.1)
                }, completion: nil)
            }
        }
        
    }
    
    func setNumberOptionLabel(text: String) {
        numberOptionLabel.text = text
    }
    func setTextOptionLabel(text: String) {
        textOptionLabel.text = text
    }
}
