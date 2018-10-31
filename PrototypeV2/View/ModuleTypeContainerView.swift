//
//  ModuleTypeContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-28.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ModuleTypeContainerView: UIView {
    
    var module: Module? {
        didSet{
            if let module = module{
                setupViews(module)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let accentBorderView: UIView = {
        let borderView = UIView()
        return borderView
    }()
    
    let moduleTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 24)
        titleLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    let moduleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "123-numbers")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleContainerView: UIView = {
        let titleContainerView = UIView()
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        return titleContainerView
    }()
    
    func setupViews(_ module: Module) {
        backgroundColor = .white
        addSubview(accentBorderView)
        addSubview(titleContainerView)
        titleContainerView.addSubview(moduleTitleLabel)
        titleContainerView.addSubview(moduleImageView)
        
        addConstraints()
        
        moduleTitleLabel.text = module.name?.rawValue
        accentBorderView.backgroundColor = module.accentColor
        moduleImageView.image = module.image?.withRenderingMode(.alwaysTemplate)
        moduleImageView.tintColor = module.accentColor
    }
    
    func addConstraints() {
        // Auto layout constraints
        accentBorderView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .zero, size: .init(width: 4, height: self.frame.height))
        
        self.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        titleContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 148).isActive = true
        titleContainerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        moduleTitleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor).isActive = true
        moduleTitleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor).isActive = true
         moduleTitleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
        moduleTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        moduleTitleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        moduleImageView.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor).isActive = true
        moduleImageView.topAnchor.constraint(equalTo: titleContainerView.topAnchor).isActive = true
        moduleImageView.leadingAnchor.constraint(equalTo: moduleTitleLabel.trailingAnchor, constant: 8).isActive = true
        moduleImageView.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
        moduleImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        moduleImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
    }
}
