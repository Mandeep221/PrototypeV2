//
//  LoginViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-19.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController, UITextFieldDelegate {
    var navbarTitleLabel: UILabel?
    var backBarButtonItem: UIBarButtonItem?
    var numberOfOtpFieldsEmpty = 6
    
    // firebase database Ref
    var ref: DatabaseReference?
    let containerForPhoneNumberScene: UIView = {
        let container = UIView()
        return container
    }()
    
    let instructionMobileNumberLabel: UILabel = {
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
        phoneTextField.tag = 0
        phoneTextField.placeholder = "9876543210"
        phoneTextField.font = UIFont(name: "Montserrat-Regular", size: 18)
        phoneTextField.textAlignment = .left
        phoneTextField.keyboardType = .numberPad
        phoneTextField.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        phoneTextField.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
        return phoneTextField
    }()
    
    let phoneBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let isdCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        label.text = "+1"
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        return label
    }()
    
    let isdBordeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(rgb: 0xFFFFFF, alpha: 1)
        return view
    }()
    
    let phoneContainerView: UIView = {
        let containerView = UIView()
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
        button.addTarget(self, action: #selector(handleSubmitPhoneNumber), for: .touchUpInside)
        return button
    }()
    
    //firebase verification ID
    var verificationId: String?
    
    //enum for scene flags
    enum sceneType: String{
        case phoneNumber = "phoneNumber"
        case otp = "Otp"
    }
    
    @objc func handleSubmitPhoneNumber() {
        
        if let phoneNum = phoneNumberTextField.text {
            // phone has text
            // create alert
            let alert = UIAlertController(title: "Phone number", message: "An OTP will be sent to \n \(phoneNum)", preferredStyle: .alert)
            
            let actionSendOtp = UIAlertAction(title: "Send OTP", style: .default) { (UIAlertAction) in
                PhoneAuthProvider.provider().verifyPhoneNumber(String("+1")+phoneNum, uiDelegate: nil, completion: { (verificationId, error) in
                    if(error != nil){
                        print("Auth error: \(String(describing: error?.localizedDescription))")
                    }else{
                        // Success Scenario, Save the verification code
                        // this code will be used along with otp verification
                        self.verificationId = verificationId

                        // Jump to the OTP screen
                        self.changeScene(sceneId: sceneType.otp.rawValue)
                    }
                })
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(actionSendOtp)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    let containerForOtpScene: UIView = {
        let container = UIView()
        container.alpha = 0
        return container
    }()
    
    let instructionOtpLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(rgb: 0xFFFFFF, alpha: 0.4)
        label.text = "A 6 digit OTP has been sent on your\n mobile number"
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
    
    let resendOtpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 0.4).cgColor
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 13)
        button.setTitle("Resend OTP", for: .normal)
        button.setTitleColor(UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1), for: .normal)
        button.tintColor = UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(handleProceed), for: .touchUpInside)
        return button
    }()
    
    let verifyOtpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        let image = UIImage(named: "right_arrow")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleVerifyOtp), for: .touchUpInside)
        return button
    }()
    
    @objc func handleVerifyOtp() {
        let credentials: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId!, verificationCode: getCode())
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let error = error{
                print("error: \(error.localizedDescription)")
            }else{
                // Success Scenario
                
                //check if user is returning or new
                self.ref?.child("users").child((user?.uid)!).child("mobile").observeSingleEvent(of: .value, with: {(snap) in
                    
                    if snap.exists(){
                        
                        // User mobile number already in DB, So user is returing
                        print("Returing User")
                    }else{
                        //Phone number not available, User is new
                        print("New User")
                        self.ref?.child("users").child((user?.uid)!).child("mobile").setValue(user?.phoneNumber)
                    }
                })
                
                print("sucessfully logged in...")
            }
        }
    }
    
    private func getCode() -> String {
        return otpCellFields[0].text! + otpCellFields[1].text! + otpCellFields[2].text! + otpCellFields[3].text! + otpCellFields[4].text! + otpCellFields[5].text!
    }
    
    func changeScene(sceneId: String) {
        if sceneId == sceneType.phoneNumber.rawValue{
            navigationItem.leftBarButtonItem = nil
            changeNavigationBarTitle(title: "Enter your mobile number")
            phoneNumberTextField.becomeFirstResponder()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                // show all phone number scene views
                self.containerForPhoneNumberScene.alpha = 1
                self.containerForPhoneNumberScene.transform = self.containerForPhoneNumberScene.transform.translatedBy(x: self.containerForPhoneNumberScene.frame.width, y: 0)
                
                // hide all otp scene views
                self.containerForOtpScene.alpha = 0
                self.containerForOtpScene.transform = self.containerForOtpScene.transform.translatedBy(x: self.containerForOtpScene.frame.width, y: 0)
            }, completion: nil)
        }else if sceneId == sceneType.otp.rawValue{
            navigationItem.leftBarButtonItem = backBarButtonItem
            changeNavigationBarTitle(title: "Verify your mobile number")
            otpCellFields[0].becomeFirstResponder()
            clearAllFields()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                // hide all phone number scene views
                self.containerForPhoneNumberScene.alpha = 0
                self.containerForPhoneNumberScene.transform = self.containerForPhoneNumberScene.transform.translatedBy(x: -self.containerForPhoneNumberScene.frame.width, y: 0)
                
                // show all otp scene views
                self.containerForOtpScene.alpha = 1
                self.containerForOtpScene.transform = CGAffineTransform(translationX: -self.containerForOtpScene.frame.width, y: 0)
            }, completion: nil)
        }
    }
    
    func clearAllFields() {
        for index in 0..<otpCellFields.count {
            otpCellFields[index].text = ""
        }
        
        // hide verify button
        verifyOtpButton.alpha = 0
    }
    
    @objc func textfieldDidChange(textField: UITextField) {
        if textField.tag == 0 {
            // #TODO: Fix this deprecated code
            if textField.text?.characters.count == 10{
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
        }else{
            let text = textField.text
            changeOtpTextFieldBorder(currentTextField: textField)
            if text?.utf16.count == 1 {
                numberOfOtpFieldsEmpty-=1
                switch textField{
                case otpCellFields[0]:
                    otpCellFields[1].becomeFirstResponder()
                case otpCellFields[1]:
                    otpCellFields[2].becomeFirstResponder()
                case otpCellFields[2]:
                    otpCellFields[3].becomeFirstResponder()
                case otpCellFields[3]:
                    otpCellFields[4].becomeFirstResponder()
                case otpCellFields[4]:
                    otpCellFields[5].becomeFirstResponder()
                case otpCellFields[5]:
                    otpCellFields[5].resignFirstResponder()
                default:
                    break
                }
            }else{
                numberOfOtpFieldsEmpty+=1
            }
            
            if numberOfOtpFieldsEmpty == 0{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.verifyOtpButton.alpha = 1
                    self.verifyOtpButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.verifyOtpButton.alpha = 0
                    self.verifyOtpButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }, completion: nil)
            }
        }
    }
    
    func changeOtpTextFieldBorder(currentTextField: UITextField) {
        let text = currentTextField.text
        if text?.utf16.count == 1{
            currentTextField.layer.borderWidth = 1
            currentTextField.layer.borderColor = UIColor(rgb: Color.orange.rawValue, alpha: 1).cgColor
        }else{
            currentTextField.layer.borderWidth = 0
        }
    }
    
    // limit the phone length to 13 characters, including ISD code
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length + range.location > (textField.text?.count)!{
            
            return false
        }
        
        let newLength = (textField.text?.count)! + string.count - range.length
        
        if(textField.tag == 0){
            // for phone number field
            return newLength <= 10
        }else{
            // for 1 digit Otp field
            return newLength <= 1
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(rgb: Color.primary.rawValue, alpha: 1)
        
        setupNavigationBar()
        addViews()
        addConstraints()
        
        // add background gradient
//        let gradient = CAGradientLayer()
//        gradient.frame = view.bounds
//        gradient.colors = [UIColor.init(rgb: Color.primaryPurple.rawValue, alpha: 1).cgColor, UIColor.init(rgb: Color.primaryBlue.rawValue, alpha: 1).cgColor]
//        view.layer.insertSublayer(gradient, at: 0)
//
    }
    
    func setupNavigationBar() {
        self.edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIColor.init(rgb: 0x323260, alpha: 1).as1ptImage()
        
        // back button
        let backImage = UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal)
        backBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(handleBackBarButton))
        
        // Custom Navigation bar title
        navbarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        if let navbarTitleLabel = navbarTitleLabel{
            navbarTitleLabel.text = "Enter your mobile number"
            navbarTitleLabel.textColor = UIColor.init(rgb: Color.whiteColor.rawValue, alpha: 1)
            navbarTitleLabel.textAlignment = .center
            navbarTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
            navigationItem.titleView = navbarTitleLabel
        }
        
    }
    
    @objc func handleBackBarButton() {
        changeScene(sceneId: sceneType.phoneNumber.rawValue)
    }
    
    func addViews() {
        //add Mobile input views
        view.addSubview(containerForPhoneNumberScene)
        containerForPhoneNumberScene.addSubview(instructionMobileNumberLabel)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.becomeFirstResponder()
        containerForPhoneNumberScene.addSubview(phoneContainerView)
        phoneContainerView.addSubview(phoneNumberTextField)
        phoneContainerView.addSubview(isdCodeLabel)
        containerForPhoneNumberScene.addSubview(phoneBorderView)
        containerForPhoneNumberScene.addSubview(isdBordeView)
        containerForPhoneNumberScene.addSubview(proceedButton)
        
        //add OTP views
        view.addSubview(containerForOtpScene)
        containerForOtpScene.addSubview(instructionOtpLabel)
        containerForOtpScene.addSubview(otpCellsContainerView)
        containerForOtpScene.addSubview(resendOtpButton)
        containerForOtpScene.addSubview(verifyOtpButton)
        setUpOtpCells()
    }
    
    func addConstraints() {
        // For Mobile number screen
        
        containerForPhoneNumberScene.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.frame.width, height: view.frame.height))
        
        instructionMobileNumberLabel.anchor(top: containerForPhoneNumberScene.topAnchor, leading: containerForPhoneNumberScene.leadingAnchor, bottom: nil, trailing: containerForPhoneNumberScene.trailingAnchor, padding: .init(top: 24, left: 20, bottom: 0, right: 20), size: .init(width: view.frame.width, height: 48))
        
        phoneContainerView.anchor(top: instructionMobileNumberLabel.bottomAnchor, leading: containerForPhoneNumberScene.leadingAnchor, bottom: nil, trailing: containerForPhoneNumberScene.trailingAnchor, padding: .init(top: 32, left: 64, bottom: 0, right: 64), size: .init(width: view.frame.width, height: 48))

        isdCodeLabel.anchor(top: phoneContainerView.topAnchor, leading: phoneContainerView.leadingAnchor, bottom: phoneContainerView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .init(width: 48, height: 48))
        
        isdBordeView.anchor(top: isdCodeLabel.bottomAnchor, leading: isdCodeLabel.leadingAnchor, bottom: nil, trailing: isdCodeLabel.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 8), size: .init(width: 48, height: 1))
        
        phoneNumberTextField.anchor(top: phoneContainerView.topAnchor, leading: isdCodeLabel.trailingAnchor, bottom: phoneContainerView.bottomAnchor, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .zero)
        
        phoneBorderView.anchor(top: phoneContainerView.bottomAnchor, leading: phoneNumberTextField.leadingAnchor, bottom: nil, trailing: phoneContainerView.trailingAnchor, padding: .zero, size: .init(width: phoneNumberTextField.frame.width, height: 1))
        
        proceedButton.topAnchor.constraint(equalTo: phoneContainerView.bottomAnchor, constant: 48).isActive = true
        proceedButton.centerXAnchor.constraint(equalTo: containerForPhoneNumberScene.centerXAnchor).isActive = true
        
        proceedButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // For OTP screen
        
        // set containerForOtpScene's leading anchor to view's trailing anchor so it can be animated from right to left, when moving from phone no. scene to otp scene
        containerForOtpScene.anchor(top: view.topAnchor, leading: view.trailingAnchor, bottom: nil, trailing: nil, padding: .zero, size: .init(width: view.frame.width, height: view.frame.height))
        
        instructionOtpLabel.anchor(top: containerForOtpScene.topAnchor, leading: containerForOtpScene.leadingAnchor, bottom: nil, trailing: containerForOtpScene.trailingAnchor, padding: .init(top: 24, left: 20, bottom: 0, right: 20), size: .init(width: containerForOtpScene.frame.width, height: 48))
        
        otpCellsContainerView.topAnchor.constraint(equalTo: instructionOtpLabel.bottomAnchor, constant: 32).isActive = true
        otpCellsContainerView.centerXAnchor.constraint(equalTo: containerForOtpScene.centerXAnchor).isActive = true
        let totalWidthOfOtpCellContainer = 6 * optCellWidth + 5 * otpCellGap
        otpCellsContainerView.widthAnchor.constraint(equalToConstant: totalWidthOfOtpCellContainer).isActive = true
        otpCellsContainerView.heightAnchor.constraint(equalToConstant: otpCellHeight).isActive = true
        
        resendOtpButton.topAnchor.constraint(equalTo: otpCellsContainerView.bottomAnchor, constant: 20).isActive = true
        resendOtpButton.centerXAnchor.constraint(equalTo: containerForOtpScene.centerXAnchor).isActive = true
        resendOtpButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        resendOtpButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        verifyOtpButton.topAnchor.constraint(equalTo: resendOtpButton.bottomAnchor, constant: 20).isActive = true
        verifyOtpButton.centerXAnchor.constraint(equalTo: containerForOtpScene.centerXAnchor).isActive = true
        
        verifyOtpButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        verifyOtpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // translate the OTP container to extreme right ,so that it can be animated in towards left
    func translateOtpContainerToRight() {
        //self.containerForOtpScene.transform = self.containerForOtpScene.transform.translatedBy(x: self.containerForOtpScene.frame.width, y: 0)
        self.containerForOtpScene.transform = CGAffineTransform(translationX: self.containerForOtpScene.frame.width, y: 0)
    }
    
    func setUpOtpCells() {
        for index in 0..<6{
            let otpCell = UITextField()
            otpCell.delegate = self
            otpCell.tag = index + 1
            otpCell.translatesAutoresizingMaskIntoConstraints = false
            otpCell.backgroundColor = .white
            otpCell.font = UIFont(name: "Montserrat-Regular", size: 18)
            otpCell.textAlignment = .center
            otpCell.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
            otpCell.keyboardType = .numberPad
            otpCell.layer.cornerRadius = 8
            otpCell.addTarget(self, action: #selector(textfieldDidChange), for: .editingChanged)
            addCellToContainer(otpCell: otpCell, index: index)
            otpCellFields.append(otpCell)
        }
    }
    
    func addCellToContainer(otpCell: UITextField, index: Int) {
        otpCellsContainerView.addSubview(otpCell)

        // constraint
        let marginFromLeadingEdge = CGFloat(index) * optCellWidth + CGFloat(index) * otpCellGap
        otpCell.leadingAnchor.constraint(equalTo: otpCellsContainerView.leadingAnchor, constant: marginFromLeadingEdge).isActive = true
        otpCell.topAnchor.constraint(equalTo: otpCellsContainerView.topAnchor).isActive = true
        otpCell.bottomAnchor.constraint(equalTo: otpCellsContainerView.bottomAnchor).isActive = true
        otpCell.widthAnchor.constraint(equalToConstant: optCellWidth).isActive = true
        otpCell.widthAnchor.constraint(equalToConstant: otpCellHeight).isActive = true
    }
    
    func changeNavigationBarTitle(title: String){
        if let navbarTitleLabel =  navbarTitleLabel{
            navbarTitleLabel.text = title
            navigationItem.titleView = navbarTitleLabel
        }
    }
    
    // changes status bar content in wite color: date, battery etc
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
