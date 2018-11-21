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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupDropDown()
        
        // Do any additional setup after loading the view.
    }
    
    func setupDropDown() {
        //Configure the button
        dropDownButton = DropDownButton.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropDownButton.setTitle("Choose Module", for: .normal)
        dropDownButton.setTitleColor(UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1), for: .normal)
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        dropDownButton.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        dropDownButton.layer.shadowRadius = 8
        dropDownButton.layer.shadowOpacity = 0.5
        dropDownButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        //Add Button to the View Controller
        self.view.addSubview(dropDownButton)
        
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
