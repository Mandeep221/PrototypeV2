//
//  SetChallengeController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-20.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class SetChallengeController: UIViewController {
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
    
    let validationErrorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
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
        validateInputs()
    }
    
    func validateInputs() -> Bool {
        let moduleType = dropDownButton.titleLabel!.text!
        
        if moduleType == "Choose Module"{
            dropDownButton.shake()
            showErrorMessage(msg: "Please select module")
            return false
        }else if (num1TextField.text?.isEmpty)!{
            if (num2TextField.text?.isEmpty)! && moduleType != ModuleType.counting.rawValue{
                //                if moduleType == ModuleType.counting.rawValue{
                //                    showErrorMessage(msg: "#1 can't be empty")
                //                }else{
                //                    showErrorMessage(msg: "#1 and #2 can't be empty")
                //                }
                showErrorMessage(msg: "#1 and #2 can't be empty")
                num1TextField.shake()
                num2TextField.shake()
                return false
            }
            showErrorMessage(msg: "#1 can't be empty")
            num1TextField.shake()
            return false
        }else if (num2TextField.text?.isEmpty)! && moduleType != ModuleType.counting.rawValue{
            showErrorMessage(msg: "#2 can't be empty")
            num2TextField.shake()
            return false
        }
        
        let num1 = Int(num1TextField.text!)!
        var num2 = 0
        if moduleType != ModuleType.counting.rawValue{
            num2 = Int(num2TextField.text!)!
        }
        if moduleType == ModuleType.counting.rawValue {
            if num1 > 30{
                print("validateInputs: ", "num1 needs to be less than equal to 30")
                showErrorMessage(msg: "#1 needs to be less than 30")
                return false
            }
        }else if moduleType == ModuleType.addition.rawValue {
            if num1 > 20 || num2 > 20{
                print("validateInputs: ", "num1 or num2 is greater than 20")
                showErrorMessage(msg: "#1 and #2 noth need to be less than or equal to 20")
                return false
            }
        }else if moduleType == ModuleType.subtraction.rawValue {
            if num1 > 20 || num2 > 20{
                print("validateInputs: ", "num1 or num2 is greater than 20")
                showErrorMessage(msg: "#1 and #2 need to be less than or equal to 20")
                return false
            }else if num2 > num1{
                print("validateInputs: ", "num2 is greater than num1")
                showErrorMessage(msg: "#2 needs to be less than #1")
                return false
            }
        }else if moduleType == ModuleType.multiplication.rawValue {
            if num1 > 10 || num2 > 10{
                print("validateInputs: ", "num1 or num2 is greater than 10")
                showErrorMessage(msg: "#1 and #2 need to be less than or equal to 10")
                return false
            }
        }else if moduleType == ModuleType.division.rawValue {
            if num1 > 20 || num2 > 20{
                print("validateInputs: ", "num1 or num2 is greater than 10")
                showErrorMessage(msg: "#1 and #2 need to be less than or equal to 20")
                return false
            }else if num2 > num1{
                showErrorMessage(msg: "#2 needs to be less than #1")
                print("validateInputs: ", "num2 is greater than num1")
                return false
            }else if num2 == 0 {
                showErrorMessage(msg: "#2 can't be zero")
                print("validateInputs: ", "num2 cannot be zero")
                return false
            }else if num1 % num2 != 0{
                showErrorMessage(msg: "Numbers should be perfectly divisible, Edit and try again")
                print("validateInputs: ", "Numbers should be perfectly divisible, Edit and try again")
                return false
            }
        }
        //print("validateInputs", moduleType)
        Utility.submitChallenge(moduleType: moduleType, num1: num1, num2: num2)
        print("validateInputs: ", "all good")
        self.navigationController?.popViewController(animated: true)
        return false
    }
    
    func showErrorMessage(msg: String) {
        validationErrorLabel.text = msg
        
        UIView.animate(withDuration: 0.5) {
            self.validationErrorLabel.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            UIView.animate(withDuration: 0.5) {
                self.validationErrorLabel.alpha = 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(dropDownButton)
        view.addSubview(num1Label)
        view.addSubview(num2Label)
        view.addSubview(num1TextField)
        view.addSubview(num2TextField)
        view.addSubview(submitButton)
        view.addSubview(validationErrorLabel)
        
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
        
        validationErrorLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20).isActive = true
        validationErrorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        validationErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        validationErrorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.sendSubviewToBack(num1Label)
        view.sendSubviewToBack(num2Label)
        view.sendSubviewToBack(num1TextField)
        view.sendSubviewToBack(num2TextField)
        view.sendSubviewToBack(num1TextField)
        view.sendSubviewToBack(submitButton)
        view.sendSubviewToBack(validationErrorLabel)
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
        
        // Custom Navigation bar title
        let navbarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        
            navbarTitleLabel.text = "Set challenge"
            navbarTitleLabel.textColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
            navbarTitleLabel.textAlignment = .center
            navbarTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
            navigationItem.titleView = navbarTitleLabel
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
