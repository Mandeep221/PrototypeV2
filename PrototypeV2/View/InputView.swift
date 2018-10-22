//
//  InputView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class InputView: UIView {

    let titleHeight: CGFloat = 0
    let valueHeight: CGFloat = 48
    let gapBetweenTitleAndValue: CGFloat = 0
    lazy var totalInputViewHeight: CGFloat = titleHeight + valueHeight + gapBetweenTitleAndValue
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xFFFFFF, alpha: 0.4)
        label.text = "Name"
        label.font = UIFont(name: "Montserrat-Bold", size: 11)
        return label
    }()
    
    let valueTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Montserrat-Regular", size: 12)
        textField.textColor = .white
        textField.addPadding(.left(20))
        textField.backgroundColor = UIColor(rgb: 0x23234F, alpha: 1)
         //textField.backgroundColor = UIColor(rgb: 0xFFFFFF, alpha: 1)
        textField.layer.masksToBounds = false
        textField.layer.cornerRadius = 24
//        textField.layer.shadowColor = UIColor(white: 0.2, alpha: 0.3).cgColor
//        textField.layer.shadowRadius = 1
//        textField.layer.shadowOpacity = 0.9
//        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
//        
        
        //textField.layer.addSublayer(addInnerShadow())
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        addSubview(titleLabel)
        addSubview(valueTextField)
        addInnerShadow()
        //valueTextField.layer.addSublayer(addInnerShadow())
        // constraints
        // titleLabel
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: self.frame.width, height: titleHeight))
        
        // valueLabel
        valueTextField.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: gapBetweenTitleAndValue, left: 12, bottom: 0, right: 12), size: .init(width: self.frame.width, height: valueHeight))
        
        titleLabel.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addInnerShadow() {
        let innerShadow = CALayer()
        innerShadow.frame = bounds
        
        // Shadow path (1pt ring around bounds)
        let radius = 12
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -1, dy:-1), cornerRadius:CGFloat(radius))
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius:CGFloat(radius)).reversing()
        
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        // Shadow properties
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 4, height: 3)
        innerShadow.shadowOpacity = 0.15
        innerShadow.shadowRadius = 3
        innerShadow.cornerRadius = 8
        
        //return innerShadow
        
        valueTextField.layer.addSublayer(innerShadow)
    }

}
