//
//  LoginViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-19.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    
    let instructionMobileNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.4)
        label.text = "You will receive an OTP on your mobile\n number for verification"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let phoneNumberTextField: UITextField = {
        let phoneTextField = UITextField()
        phoneTextField.text = "+1 "
        phoneTextField.font = UIFont(name: "Montserrat-Regular", size: 18)
        phoneTextField.textAlignment = .center
        phoneTextField.keyboardType = .numberPad
        phoneTextField.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        phoneTextField.isHidden = true
        // edit action
        phoneTextField.addTarget(self, action: #selector(phoneTextfieldDidChange), for: .editingChanged)
        return phoneTextField
    }()
    
    let isdCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "+1"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.isHidden = true
        return label
    }()
    
    let phoneBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    let phoneContainerView: UIView = {
        let containerView = UIView()
        containerView.isHidden = true
        return containerView
    }()
    
    let proceedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        let image = UIImage(named: "right_arrow")
        button.setImage(image, for: .normal)
        button.alpha = 0
        button.tintColor = UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let instructionOtpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.4)
        label.text = "A 4 digit OTP has been sent on your\n mobile number"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    let optCellWidth: CGFloat = 44
    let otpCellHeight: CGFloat = 44
    let otpCellGap: CGFloat = 6
    var otpCellFields = [UITextField]()
    
    let otpCellsContainerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    
    @objc func phoneTextfieldDidChange(textField: UITextField) {
        // #TODO: Fix this deprecated code
        if textField.text?.characters.count == 13{
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.proceedButton.alpha = 1
                self.proceedButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.proceedButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.proceedButton.alpha = 0
            }, completion: nil)
        }
    }
    
    // limit the phone length to 13 characters, including ISD code
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 13
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
        titleLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        navigationItem.titleView = titleLabel
        
        // add background gradient
//        let gradient = CAGradientLayer()
//        gradient.frame = view.bounds
//        gradient.colors = [UIColor.init(rgb: Color.primaryPurple.rawValue, alpha: 1).cgColor, UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 1).cgColor]
//        view.layer.insertSublayer(gradient, at: 0)
//
        view.backgroundColor = UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
        
        //add Mobile input views
        phoneNumberTextField.delegate = self
        
        view.addSubview(instructionMobileNumberLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(phoneContainerView)
        phoneContainerView.addSubview(phoneNumberTextField)
        phoneContainerView.addSubview(isdCodeLabel)
        phoneContainerView.addSubview(phoneBorderView)
        view.addSubview(proceedButton)
        
        //add OTP views
        view.addSubview(instructionOtpLabel)
        view.addSubview(otpCellsContainerView)
        setUpOtpCells()
        // Constraints
        // For Mobile number screen
        instructionMobileNumberLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 20, bottom: 0, right: 20), size: .init(width: view.frame.width, height: 48))
        
        phoneContainerView.anchor(top: instructionMobileNumberLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32), size: .init(width: view.frame.width, height: 49))
        
        phoneNumberTextField.anchor(top: phoneContainerView.topAnchor, leading: phoneContainerView.leadingAnchor, bottom: phoneBorderView.bottomAnchor, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .zero)
        
        phoneBorderView.anchor(top: nil, leading: phoneContainerView.leadingAnchor, bottom: phoneContainerView.bottomAnchor, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .init(width: phoneContainerView.frame.width, height: 1))
        
        proceedButton.topAnchor.constraint(equalTo: phoneContainerView.bottomAnchor, constant: 48).isActive = true
        proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        proceedButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // For OTP screen
        instructionOtpLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 20, bottom: 0, right: 20), size: .init(width: view.frame.width, height: 48))
        
        otpCellsContainerView.topAnchor.constraint(equalTo: instructionOtpLabel.bottomAnchor, constant: 32).isActive = true
        otpCellsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let totalWidthOfOtpCellContainer = 6 * optCellWidth + 5 * otpCellGap
        otpCellsContainerView.widthAnchor.constraint(equalToConstant: totalWidthOfOtpCellContainer).isActive = true
        otpCellsContainerView.heightAnchor.constraint(equalToConstant: otpCellHeight).isActive = true
        
        
//        otpCellsContainerView.anchor(top: instructionOtpLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 32), size: .init(width: optCellWidth * 6, height: otpCellHeight))
//
    }
    
    func setUpOtpCells() {
        for index in 0..<6{
            let otpCell = UITextField()
            otpCell.translatesAutoresizingMaskIntoConstraints = false
            otpCell.backgroundColor = .white
            otpCell.font = UIFont(name: "Montserrat-Regular", size: 18)
            otpCell.textAlignment = .center
            otpCell.keyboardType = .numberPad
            otpCell.layer.cornerRadius = 8
            addCellToContaine(otpCell: otpCell, index: index)
            otpCellFields.append(otpCell)
        }
    }
    
    func addCellToContaine(otpCell: UITextField, index: Int) {
        otpCellsContainerView.addSubview(otpCell)
        // constraint
        let marginFromLeadingEdge = CGFloat(index) * optCellWidth + CGFloat(index) * otpCellGap
        otpCell.leadingAnchor.constraint(equalTo: otpCellsContainerView.leadingAnchor, constant: marginFromLeadingEdge).isActive = true
        otpCell.topAnchor.constraint(equalTo: otpCellsContainerView.topAnchor).isActive = true
        otpCell.bottomAnchor.constraint(equalTo: otpCellsContainerView.bottomAnchor).isActive = true
        otpCell.widthAnchor.constraint(equalToConstant: optCellWidth).isActive = true
        otpCell.widthAnchor.constraint(equalToConstant: otpCellHeight).isActive = true
        
//        if index % 2 == 0 {
//            otpCell.backgroundColor = .red
//        }else{
//            otpCell.backgroundColor = .blue
//        }
    }
    // changes status bar content in wite color: date, battery etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
