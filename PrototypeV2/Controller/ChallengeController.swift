//
//  ChallengeController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ChallengeController: UIViewController {
    var dropDownButton = DropDownButton()
    
    let num1Label: UILabel = {
        let label = UILabel()
        label.text = "#1"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    let num2Label: UILabel = {
        let label = UILabel()
        label.text = "#2"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    
    let num1TextField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.placeholder = "First number"
        textField.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        textField.font = UIFont(name: "Montserrat-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        return textField
    }()

    let num2TextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.placeholder = "Second number"
        textField.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        textField.font = UIFont(name: "Montserrat-Regular", size: 16)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1), for: .normal)
        button.tintColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
        button.backgroundColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
        button.addTarget(self, action: #selector(handleSubmitChallenge), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSubmitChallenge(){
        let moduleType = dropDownButton.titleLabel!.text!
        let num1 = Int(num1TextField.text!)!
        var num2 = 0
        if moduleType != ModuleType.counting.rawValue{
            num2 = Int(num2TextField.text!)!
        }
        Utility.submitChallenge(moduleType: moduleType, num1: num1, num2: num2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dropDownButton)
        view.addSubview(num1Label)
        view.addSubview(num2Label)
        view.addSubview(num1TextField)
        view.addSubview(num2TextField)
        view.addSubview(submitButton)
        
        setupNavBar()
        setupDropDown()
        
        // add constraints
        addConstraints()

        // Do any additional setup after loading the view.
    }
    
    func addConstraints() {
        num1Label.leftAnchor.constraint(equalTo: dropDownButton.leftAnchor).isActive = true
        num1Label.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor, constant: 20).isActive = true
        num1Label.widthAnchor.constraint(equalToConstant: 24).isActive = true
        num1Label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        num2Label.leftAnchor.constraint(equalTo: num1Label.leftAnchor).isActive = true
        num2Label.topAnchor.constraint(equalTo: num1Label.bottomAnchor, constant: 20).isActive = true
        num2Label.widthAnchor.constraint(equalToConstant: 24).isActive = true
        num2Label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        num1TextField.leftAnchor.constraint(equalTo: num1Label.rightAnchor, constant: 16).isActive = true
        num1TextField.topAnchor.constraint(equalTo: dropDownButton.bottomAnchor, constant: 20).isActive = true
        num1TextField.rightAnchor.constraint(equalTo: dropDownButton.rightAnchor).isActive = true
        //num1TextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        num1TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        num2TextField.leftAnchor.constraint(equalTo: num1Label.rightAnchor, constant: 16).isActive = true
        num2TextField.topAnchor.constraint(equalTo: num1Label.bottomAnchor, constant: 20).isActive = true
        num2TextField.rightAnchor.constraint(equalTo: dropDownButton.rightAnchor).isActive = true
        //num2TextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        num2TextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submitButton.topAnchor.constraint(equalTo: num2Label.bottomAnchor, constant: 32).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        view.sendSubviewToBack(num1Label)
        view.sendSubviewToBack(num2Label)
        view.sendSubviewToBack(num1TextField)
        view.sendSubviewToBack(num2TextField)
        view.sendSubviewToBack(num1TextField)
        view.sendSubviewToBack(submitButton)
    }
    
    override func viewDidLayoutSubviews() {
        view.bringSubviewToFront(dropDownButton)
    }
    
    func setupDropDown() {
        //Configure the button
//        dropDownButton = DropDownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropDownButton.viewRef = self
        dropDownButton.setTitle("Choose Module", for: .normal)
        dropDownButton.setImage(UIImage(named: "icon_chevron"), for: .normal)
        dropDownButton.setTitleColor(UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1), for: .normal)
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        dropDownButton.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        dropDownButton.layer.shadowRadius = 8
        dropDownButton.layer.shadowOpacity = 0.5
        dropDownButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        dropDownButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        dropDownButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        dropDownButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        //button Constraints
        dropDownButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dropDownButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
        dropDownButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        dropDownButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Set the drop down menu's options
        dropDownButton.dropView.dropDownOptions = ModuleType.allRawValues
    }

    func setupNavBar() {
        self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
