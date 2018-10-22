//
//  LoginViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-19.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.4)
        label.text = "You will receive an OTP on your mobile\n number for verification"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let phoneTextField = UITextField()
        phoneTextField.text = "+1 "
        phoneTextField.font = UIFont(name: "Montserrat-Regular", size: 18)
        phoneTextField.textAlignment = .center
        phoneTextField.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        return phoneTextField
    }()
    
    let isdCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "+1"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    let phoneBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let phoneContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    let proceedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 21
        return button
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(range)
        print(string)
        
//        if (textField.text?.characters.count == 1) {//When detect backspace when have one character.
//            textField.text = "myText"
//        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIColor.init(rgb: 0x323260, alpha: 1).as1ptImage()
        
        // Custom Navigation bar title
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Enter your mobile number"
        //titleLabel.textColor = UIColor.init(rgb: 0x8C8EAC, alpha: 1)
        titleLabel.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        navigationItem.titleView = titleLabel
        
        view.backgroundColor = UIColor.init(rgb: 0x2B2D5C, alpha: 1)
        //view.backgroundColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        //23234F : input color
        //add views
        phoneNumberTextField.delegate = self
        
        view.addSubview(instructionLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(phoneContainerView)
        view.addSubview(proceedButton)
        phoneContainerView.addSubview(phoneNumberTextField)
        phoneContainerView.addSubview(isdCodeLabel)
        phoneContainerView.addSubview(phoneBorderView)
        
        // Constraints
        instructionLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 20, bottom: 0, right: 20), size: .init(width: view.frame.width, height: 48))
        
//        phoneNumberTextField.anchor(top: instructionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32), size: .init(width: view.frame.width, height: 48))
        
        phoneContainerView.anchor(top: instructionLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32), size: .init(width: view.frame.width, height: 49))
        
        phoneNumberTextField.anchor(top: phoneContainerView.topAnchor, leading: phoneContainerView.leadingAnchor, bottom: phoneBorderView.bottomAnchor, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .zero)
        
        phoneBorderView.anchor(top: nil, leading: phoneContainerView.leadingAnchor, bottom: phoneContainerView.bottomAnchor, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .init(width: phoneContainerView.frame.width, height: 1))
        
//        proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        proceedButton.topAnchor.constraint(equalTo: phoneContainerView.bottomAnchor).isActive = true
//        proceedButton.widthAnchor.constraint(equalToConstant: 42)
//        proceedButton.heightAnchor.constraint(equalToConstant: 42)
        
    }
    
    
    
    // changes status bar content in wite color: date, battery etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
