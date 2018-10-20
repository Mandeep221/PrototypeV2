//
//  LoginViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-19.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let inputsContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //containerView.backgroundColor = .white
        return containerView
    }()
    
    let nameInput: InputView = {
       let name = InputView()
        name.titleLabel.text = "NAME"
        name.valueTextField.placeholder = "Name"
        return name
    }()
    
    let emailInput: InputView = {
        let email = InputView()
        email.titleLabel.text = "EMAIL"
        email.valueTextField.placeholder = "Email"
        return email
    }()
    
    let passwordInput: InputView = {
        let password = InputView()
        password.titleLabel.text = "PASSWORD"
        password.valueTextField.placeholder = "Password"
        return password
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        return label
    }()
    
    
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "Name"
        name.backgroundColor = .red
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        
        view.backgroundColor = UIColor.init(rgb: 0x2B2D5C, alpha: 1)
        //23234F : input color
        //add views
        view.addSubview(inputsContainerView)
        inputsContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12), size: .init(width: view.frame.width, height: nameInput.totalInputViewHeight * 3))
        
        inputsContainerView.addSubview(nameInput)
        inputsContainerView.addSubview(emailInput)
        inputsContainerView.addSubview(passwordInput)
        
        // name constraint
        nameInput.anchor(top: inputsContainerView.topAnchor, leading: inputsContainerView.leadingAnchor, bottom: nil, trailing: inputsContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size:.init(width: inputsContainerView.frame.width, height: nameInput.totalInputViewHeight))
        
        // email constraint
        emailInput.anchor(top: nameInput.bottomAnchor, leading: inputsContainerView.leadingAnchor, bottom: nil, trailing: inputsContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size:.init(width: inputsContainerView.frame.width, height: emailInput.totalInputViewHeight))
        
        // password constraint
        passwordInput.anchor(top: emailInput.bottomAnchor, leading: inputsContainerView.leadingAnchor, bottom: nil, trailing: inputsContainerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size:.init(width: inputsContainerView.frame.width, height: passwordInput.totalInputViewHeight))
        
    }
    
    func setupInputsContainerView() {
        //add constraints
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameLabel)
        
        // add name constraints
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // add name label constraints
        nameLabel.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    // changes status bar content in wite color: date, battery etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
