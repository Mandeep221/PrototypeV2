//
//  ModuleTypeContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-28.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ModuleTypeContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let accentBorderView: UIView = {
        let borderView = UIView()
        return borderView
    }()
    
    func setupViews() {
        backgroundColor = .white
        addSubview(accentBorderView)
        
        // Auto layout constraints
        accentBorderView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .zero, size: .init(width: 4, height: self.frame.height))
        
        self.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
//        containerView.layer.cornerRadius = containerView.frame.height / 2
//
//        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
//        containerView.layer.shadowRadius = 8
//        containerView.layer.shadowOpacity = 0.5
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
}
