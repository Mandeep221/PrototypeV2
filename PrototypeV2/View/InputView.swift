//
//  InputView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class InputView: UIView {

    let titleHeight: CGFloat = 24
    let valueHeight: CGFloat = 40
    let gapBetweenTitleAndValue: CGFloat = 4
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
        textField.placeholder = "Name"
        textField.font = UIFont(name: "Montserrat-Regular", size: 12)
        textField.textColor = .white
        textField.backgroundColor = UIColor(rgb: 0x23234F, alpha: 1)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews() {
        addSubview(titleLabel)
        addSubview(valueTextField)
        
        // constraint for titleLabel
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: self.frame.width, height: titleHeight))
        
        valueTextField.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: gapBetweenTitleAndValue, left: 12, bottom: 0, right: 12), size: .init(width: self.frame.width, height: valueHeight))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
