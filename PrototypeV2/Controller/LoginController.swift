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
        containerView.backgroundColor = .white
        return containerView
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
        view.backgroundColor = UIColor.init(rgb: 0x2B2D5C, alpha: 1)
        //23234F : input color
        //add views
        view.addSubview(inputsContainerView)
        
        setupInputsContainerView()
        
    }
    
    func setupInputsContainerView() {
        //add constraints
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
        inputsContainerView.addSubview(nameTextField)
        
        // add name constraints
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: inputsContainerView.leadingAnchor, constant: 12).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: inputsContainerView.trailingAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        print("Height: ",inputsContainerView.frame.height)
    }
    
    // changes status bar content in wite color: date, battery etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
