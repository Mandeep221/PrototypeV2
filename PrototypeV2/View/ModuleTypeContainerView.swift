//
//  ModuleTypeContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-28.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ModuleTypeContainerView: UIView, UIGestureRecognizerDelegate {
    var viewRef: HomeController?
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
    
    lazy var accentBorderView: UIView = {
        let borderView = UIView()
        borderView.clipsToBounds = true
        borderView.alpha = 1
        borderView.isUserInteractionEnabled = true
        borderView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleCancel)))
        return borderView
    }()
    
    lazy var moduleTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 24)
        titleLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //titleLabel.backgroundColor = .green
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleCancel)))
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
    
    lazy var cancelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .black
        imageView.alpha = 0
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleCancel)))
        return imageView
    }()
    
    let levelOneButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Level 1", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    lazy var levelTwoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Level 2", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.tintColor = .black
        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleCancel)))
//        button.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        return button
    }()
    
    lazy var selectToyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let iconsContainerView: UIView = {
        let containerView = UIView()
        
        //configuration options
        let iconHeight:CGFloat = 38
        let padding:CGFloat = 6
        
        let images = [#imageLiteral(resourceName: "blue_like"), #imageLiteral(resourceName: "red_heart"), #imageLiteral(resourceName: "surprised"), #imageLiteral(resourceName: "cry_laugh"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]
        
        //#TODO: This is very important short cut, it returns an array of UIViews with different colors
        let arrangedSubviews = images.map({ (image) -> UIView in
            let imageView = UIImageView(image: image)
            // required for hit testing
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = iconHeight/2
            return imageView
        })
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.distribution = .fillEqually
        
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)
        
        let iconCount = CGFloat(arrangedSubviews.count)
        let width = iconCount * iconHeight + (iconCount + 1) * padding
        
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: width, height: iconHeight + 2 * padding)
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
        containerView.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        stackView.frame = containerView.frame
        
        return containerView
    }()
    
    
    let titleContainerView: UIView = {
        let titleContainerView = UIView()
//        titleContainerView.backgroundColor = .gray
        titleContainerView.translatesAutoresizingMaskIntoConstraints = false
        return titleContainerView
    }()
    
    let optionsContainerView: UIView = {
        let optionsContainerView = UIView()
        optionsContainerView.alpha = 0
//        optionsContainerView.backgroundColor = .yellow
        optionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        return optionsContainerView
    }()
    
    func setupViews(_ module: Module) {
        backgroundColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
        
        //backgroundColor = UIColor.init(rgb: 0x290A35, alpha: 1)
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        addSubview(cancelImageView)
        addSubview(accentBorderView)
        addSubview(titleContainerView)
        titleContainerView.addSubview(moduleTitleLabel)
        titleContainerView.addSubview(moduleImageView)
        titleContainerView.addSubview(optionsContainerView)
        optionsContainerView.addSubview(levelOneButton)
        optionsContainerView.addSubview(levelTwoButton)
        optionsContainerView.addSubview(selectToyButton)
        
        addConstraints()
        
        moduleTitleLabel.text = module.name?.rawValue
        accentBorderView.backgroundColor = module.accentColor
        moduleImageView.image = module.image?.withRenderingMode(.alwaysTemplate)
        moduleImageView.tintColor = module.accentColor
        
        setupLongPressGesture()
    }
    
    func addConstraints() {
        // Auto layout constraints
        accentBorderView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .zero, size: .init(width: 4, height: self.frame.height))
        
        cancelImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        cancelImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        cancelImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        cancelImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleContainerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 148).isActive = true
//        titleContainerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        titleContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        
        moduleTitleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor).isActive = true
        moduleTitleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor).isActive = true
//         moduleTitleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
        moduleTitleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        moduleTitleLabel.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        moduleImageView.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor).isActive = true
        moduleImageView.topAnchor.constraint(equalTo: titleContainerView.topAnchor).isActive = true
        moduleImageView.leadingAnchor.constraint(equalTo: moduleTitleLabel.trailingAnchor, constant: 8).isActive = true
        moduleImageView.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor).isActive = true
        moduleImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        moduleImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        optionsContainerView.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor).isActive = true
        optionsContainerView.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor).isActive = true
        optionsContainerView.topAnchor.constraint(equalTo: moduleTitleLabel.bottomAnchor).isActive = true
        optionsContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true

        levelOneButton.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor).isActive = true
        levelOneButton.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor).isActive = true
        levelOneButton.topAnchor.constraint(equalTo: optionsContainerView.topAnchor, constant: 16).isActive = true
        levelOneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        levelTwoButton.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor).isActive = true
        levelTwoButton.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor).isActive = true
        levelTwoButton.topAnchor.constraint(equalTo: optionsContainerView.topAnchor, constant: 68).isActive = true
      levelTwoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        selectToyButton.centerXAnchor.constraint(equalTo: optionsContainerView.centerXAnchor).isActive = true
        selectToyButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        selectToyButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        selectToyButton.topAnchor.constraint(equalTo: levelTwoButton.bottomAnchor, constant: 16).isActive = true

    }
    
    private func setupLongPressGesture() {
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        print("handleLongPress: ", Date())
        
        if gesture.state == .began{
            handleGestureBegan(gesture: gesture)
        }else if gesture.state == .ended{
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                let stackview = self.iconsContainerView.subviews.first
                stackview?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                    
                })
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: 50)
                self.iconsContainerView.alpha = 0
            }, completion: { (_) in
                
                self.iconsContainerView.removeFromSuperview()
                
            })
        }else if gesture.state == .changed{
            handleGestureChanged(gesture: gesture)
        }
    }
    
    private func handleGestureChanged(gesture: UILongPressGestureRecognizer){
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        let hitTestView = iconsContainerView.hitTest(pressedLocation, with: nil)
        
        if hitTestView is UIImageView {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
                
                let stackview = self.iconsContainerView.subviews.first
                stackview?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                
                hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
            })
        }
    }
    
    func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        self.addSubview(iconsContainerView)
        let pressedLocation = gesture.location(in: self.selectToyButton)
        
        // transformation of the red box
        let centeredX = (self.frame.width - iconsContainerView.frame.width)/2
        iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        // alpha
        iconsContainerView.alpha = 0
        iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.iconsContainerView.alpha = 1.0
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
        })
    }
    
    @objc func handleCancel() {
        //viewRef?.handleLogout()
        print("Cancelled")
    }
    
    func showCancelOption(show: Bool) {
        if show{
            cancelImageView.alpha = 1
        }else{
            cancelImageView.alpha = 0
        }

    }
    
    func handleOptionsContainerVisiblity(visible: Bool) {
        if visible {
         self.optionsContainerView.alpha = 1
        }else{
            self.optionsContainerView.alpha = 0
        }
        //self.layoutIfNeeded()
    }
}
