//
//  ChallengeController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-21.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ChallengeController: UIViewController {

    let reachability = NetworkReachability()!
    
    var moduleType: String?
    var answer = 0
    var requiredNumbersForOptions: [Int]?
    
    let numViewPerRow = 8
    let numViewPerColumn = 7
    lazy var totalNumOfCells = numViewPerRow * numViewPerColumn
    var cells = [String: UIView]()
    
    var circularCellsIndices: [String]?
    
    lazy var instructionThreeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
//        if moduleType == ModuleType.counting || moduleType == ModuleType.subtraction{
//            //label.text = "Can you count the STRAWBERRIES you tapped?"
//        }else{
//            //label.text = "Can you count the SNAKES you tapped?"
//        }
        label.text = "Can you count the Circles?"
        label.alpha = 1
        return label
    }()
    
    
    lazy var optionButtons: [DesignableOptionView] = {
        var opt = [DesignableOptionView]()
        for index in 0...3 {
            let option = DesignableOptionView()
            option.backGroundColor = UIColor.init(rgb: Color.primaryPurple.rawValue, alpha: 1)
            option.isUserInteractionEnabled = true
            option.alpha = 1
            option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOptionSelection)))
            
            opt.append(option)
        }
        return opt
    }()

    lazy var networkInfoView: UIView = {
         let infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = "No Internet connection"
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = UIFont(name: "Montserrat-Bold", size: 16)
        messageLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
        messageLabel.textAlignment = .center
        
        let subMessageLabel = UILabel()
        subMessageLabel.text = "Please turn your internet on to reload the page"
        subMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        subMessageLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        subMessageLabel.textColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
        subMessageLabel.numberOfLines = 0
        subMessageLabel.textAlignment = .center
       
        infoView.addSubview(messageLabel)
        infoView.addSubview(subMessageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        subMessageLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4).isActive = true
        subMessageLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
        subMessageLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true
        subMessageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return infoView
    }()
    
    @objc func handleOptionSelection(gesture: UITapGestureRecognizer) {
        let currentView = gesture.view as! DesignableOptionView
        if optionButtons.contains(currentView){
            
            if Int(currentView.numberOptionLabel.text!) == answer{
                currentView.handleOptionClickAnimation(isCorrect: true)
                //reset()
            }else{
                currentView.handleOptionClickAnimation(isCorrect: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setUpNetworkObserver()
        if reachability.connection == .none{
            view.addSubview(networkInfoView)
            networkInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            networkInfoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            networkInfoView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            networkInfoView.heightAnchor.constraint(equalToConstant: 44).isActive = true
           
            return
        }
    }
    
    func setUpNetworkObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(internetStateChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        
        do{
            try reachability.startNotifier()
        }catch{
            print("reachability notifier could not be started")
        }
    }
    
    @objc func internetStateChanged(note: Notification) {
        let reachability = note.object as! NetworkReachability
        
        if reachability.connection != .none{
            setupViews()
            print("internetStateChanged hai")
        }else{
            print("internetStateChanged nai hai")
        }
    }
    
    func setupViews() {
        networkInfoView.alpha = 0
        circularCellsIndices = [String]()
        requiredNumbersForOptions = [Int]()
        generateCircularCellIndices()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...numViewPerColumn {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = Utility.randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                view.addSubview(cellView)
                let key = "\(i)|\(j)"
                if (circularCellsIndices?.contains(key))!{
                    cellView.layer.cornerRadius = width/2
                    cellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTap)))
                }
                cells[key] = cellView
            }
        }
        view.addSubview(instructionThreeLabel)
        
        for index in 0...optionButtons.count - 1{
            view.addSubview(optionButtons[index])
        }
        setConstraintsForOptions()
        handleAllOptions(visible: true)
    }
    
    func setConstraintsForOptions() {
        let optionOneButton = optionButtons[0]
        let optionTwoButton = optionButtons[1]
        let optionThreeButton = optionButtons[2]
        let optionFourButton = optionButtons[3]
        
        
        //#TODO: width does not make sense, but somehow works
        optionThreeButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 60))
        
        // #TODO: width does not make sense, but somehow works
        optionFourButton.anchor(top: nil, leading: optionThreeButton.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 60))
        
        optionOneButton.anchor(top: nil, leading: view.leadingAnchor, bottom: optionThreeButton.topAnchor, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 60))
        
        optionTwoButton.anchor(top: nil, leading: nil, bottom: optionFourButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 60))
        
        // for the third instruction
        instructionThreeLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: optionOneButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 8, right: 16), size: .init(width: view.frame.width, height: 30))
        
    }
    
    
    func handleAllOptions(visible: Bool) {
        self.setUpFourOptions()
        for index in 0..<optionButtons.count{
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseOut], animations:{
                if visible{
                    self.optionButtons[index].alpha = 1.0
                    self.optionButtons[index].numberOptionLabel.text = String(self.requiredNumbersForOptions![index])
                    self.optionButtons[index].textOptionLabel.text = self.requiredNumbersForOptions![index].asWord
                }else{
                    self.optionButtons[index].alpha = 0.0
                }
            }, completion: {(_) in
                
            })
        }
    }
    
    func setUpFourOptions(){
        if !requiredNumbersForOptions!.isEmpty{
            requiredNumbersForOptions?.removeAll()
        }
        requiredNumbersForOptions = generateOptions()
        
        if !requiredNumbersForOptions!.contains(answer){
            requiredNumbersForOptions?[0] = answer
            requiredNumbersForOptions?.shuffle()
        }
    }
    
    func generateOptions() -> [Int] {
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        var requiredNumbers = [Int]()
        while true{
            
            if let randomNum = numbers.randomElement(){
                if !requiredNumbers.contains(randomNum){
                    requiredNumbers.append(randomNum)
                }
            }
            
            if requiredNumbers.count == 4{
                break
            }
            
        }
        return requiredNumbers
    }
    
    func generateCircularCellIndices(){
        for _ in 0..<7{
            let num = generateRandomNumber()
            circularCellsIndices?.append(num)
        }
    }
    
    func generateRandomNumber() -> String{
        var key: String?
        while true{
            let randomRowIndex = Int.random(in: 0..<numViewPerRow)
            let randomColumnIndex = Int.random(in: 0..<numViewPerColumn)
            key = "\(randomRowIndex)|\(randomColumnIndex)"
            if !(circularCellsIndices?.contains(key!))!{
                break
            }
        }
        return key!
    }

    @objc func handleCellTap(gesture: UITapGestureRecognizer){
        let location = gesture.location(in: view)
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else {return}
        
        cellView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
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