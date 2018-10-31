//
//  ViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topMarginForInstructionLabelOne: CGFloat = 20
    
    var moduleType: ModuleType? = nil {
        didSet{
           moduleTitleLabel.text = moduleType?.rawValue
        }
    }
    
    var num1 = 0
    var num2 = 0
    var answer = 0
    
    let anchorForContainerOne: UIView = {
        let abchorView = UIView()
        //abchorView.backgroundColor = UIColor.init(rgb: 0xF7CE3E)
        abchorView.backgroundColor = .yellow
        return abchorView
    }()
    
    let anchorForContainerTwo: UIView = {
        let abchorView = UIView()
        //abchorView.backgroundColor = UIColor.init(rgb: 0xF7CE3E)
        abchorView.backgroundColor = .yellow
        return abchorView
    }()
    
    
    let moduleSubTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.numberOfLines = 2
        subTitleLabel.textColor = UIColor.init(rgb: 0xF6B691, alpha: 1)
        subTitleLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        subTitleLabel.text = "Lets learn"
        return subTitleLabel
    }()
    
    let moduleTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 32)
        titleLabel.text = "COUNTING"
        return titleLabel
    }()
    
    let instructionOneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Can you swipe two cells to the right?"
        label.alpha = 0
        return label
    }()
    
    let containerViewOne: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.cellCount = 10
        return cv
    }()
    
    let instructionTwoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Can you swipe two cells to the right?"
        label.alpha = 0
        return label
    }()
    
    let containerViewTwo: ContainerView = {
        let cv = ContainerView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.cellCount = 10
        return cv
    }()
    
    let instructionThreeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.text = "Can you count the RED cells you swiped?"
        label.alpha = 0
        return label
    }()
    
    let optionOneButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("12", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionTwoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("5", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionThreeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("9", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    let optionFourButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.init(rgb: 0x332042, alpha: 1)
        btn.setTitle("7", for: UIControlState.normal)
        btn.setTitleColor(.white, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        btn.layer.cornerRadius = 10;
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var optionButton: [DesignableOptionView] = {
        var opt = [DesignableOptionView]()
        
        for index in 0...3 {
            let option = DesignableOptionView()
            option.isUserInteractionEnabled = true
            option.alpha = 0.0
            option.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOptionSelection)))
            
            opt.append(option)
        }
        return opt
    }()
    
    @objc func handleOptionSelection(gesture: UITapGestureRecognizer) {
        let currentView = gesture.view as! DesignableOptionView
        if optionButton.contains(currentView){
            
            if Int(currentView.numberOptionLabel.text!) == answer{
                currentView.handleOptionClickAnimation(isCorrect: true)
            }else{
                currentView.handleOptionClickAnimation(isCorrect: false)
            }
            
            
        }
    }
    
    fileprivate func addViews() {
        view.addSubview(moduleSubTitleLabel)
        view.addSubview(moduleTitleLabel)
        view.addSubview(instructionOneLabel)
        view.addSubview(anchorForContainerOne)
        view.addSubview(containerViewOne)
        view.addSubview(instructionTwoLabel)
        view.addSubview(anchorForContainerTwo)
        view.addSubview(containerViewTwo)
        view.addSubview(optionOneButton)
        view.addSubview(optionTwoButton)
        view.addSubview(optionThreeButton)
        view.addSubview(optionFourButton)
        view.addSubview(instructionThreeLabel)
        
        for index in 0...optionButton.count - 1{
            view.addSubview(optionButton[index])
        }
    }
    
    fileprivate func setConstraintsForContainerTwo() {
        instructionTwoLabel.anchor(top: containerViewOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        anchorForContainerTwo.anchor(top: containerViewTwo.topAnchor, leading: view.leadingAnchor, bottom: containerViewTwo.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: (containerViewTwo.containerHeight - containerViewTwo.anchorHeight)/2, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: containerViewTwo.anchorHeight))
        
        containerViewTwo.anchor(top: instructionTwoLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: containerViewTwo.cellHeight))
    }
    
    fileprivate func setConstraintsForContainerOne() {
        instructionOneLabel.anchor(top: moduleTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topMarginForInstructionLabelOne, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        anchorForContainerOne.anchor(top: containerViewOne.topAnchor, leading: view.leadingAnchor, bottom: containerViewOne.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: (containerViewOne.containerHeight - containerViewOne.anchorHeight)/2, left: 0, bottom: 24, right: 0), size: .init(width: 0, height: containerViewOne.anchorHeight))
        
        containerViewOne.anchor(top: instructionOneLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: containerViewOne.cellHeight))
    }
    
    fileprivate func addConstraints() {
        //Auto layout constraints
        moduleSubTitleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 20))
        
        moduleTitleLabel.anchor(top: moduleSubTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        // Hide second container view if the module is counting, by not setting its constraints
        if moduleType == ModuleType.counting {
            topMarginForInstructionLabelOne = 48
            instructionTwoLabel.isHidden = true
            containerViewTwo.isHidden = true
        }else{
            setConstraintsForContainerTwo()
        }
        
        setConstraintsForContainerOne()
        setConstraintsForOptions()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerViewOne.handleSwipeDirectionHelp()
        // nav bar
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = []
        
        // provide this view controller reference to each container view
        containerViewOne.viewRef = self
        containerViewTwo.viewRef = self
        
        //#2C163B
        view.backgroundColor = UIColor(rgb: 0x2C163B, alpha: 1)
        
        addViews()
        addConstraints()
        generateTwoRandomNumbers()
        setUpFourOptions()
        setSwipableCells()
        handleScene(label: instructionOneLabel, show: true)
    }
    
    func setUpFourOptions(){
        optionButton[0].setNumberOptionLabel(text: String(num2))
        optionButton[1].setNumberOptionLabel(text: String(num1))
        optionButton[2].setNumberOptionLabel(text: String(num1 + num2))
        optionButton[3].setNumberOptionLabel(text: String(num1 > num2 ? (num1 - num2) : (num2 - num1)))
    }
    
    func setConstraintsForOptions() {
        let optionOneButton = optionButton[0]
        let optionTwoButton = optionButton[1]
        let optionThreeButton = optionButton[2]
        let optionFourButton = optionButton[3]
        
       
        //#TODO: width does not make sense, but somehow works
        optionThreeButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        // #TODO: width does not make sense, but somehow works
        optionFourButton.anchor(top: nil, leading: optionThreeButton.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionOneButton.anchor(top: nil, leading: view.leadingAnchor, bottom: optionThreeButton.topAnchor, trailing: nil, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionTwoButton.anchor(top: nil, leading: nil, bottom: optionFourButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
    
        // for the third instruction
        instructionThreeLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: optionOneButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width, height: 40))

    }
    
    
    func getX(slideCounter: Int) -> CGFloat{
        
        let leftMargin = containerViewOne.frame.width - containerViewOne.cellWidth - (CGFloat(slideCounter) * (containerViewOne.cellWidth + containerViewOne.cellGap))
        return leftMargin
    }
    
    // every time the required number of cells are swiped in each container,
    // this method updates the total number of cells swiped and stores it in the answer variable
    func updateTotalCellsSwiped(cellsSwiped: Int) {
        answer += cellsSwiped
        
        // all cells swiped in first container
        if answer == num1{
            
            if moduleType == ModuleType.counting{
                showAllOptions()
            }else{
                //hide first instruction
                handleScene(label: instructionOneLabel, show: false)
                
                //show second instruction
                handleScene(label: instructionTwoLabel , show: true)
            }
        }
        
        // when all the cells have been swiped in both containers, total will be the answer of final count
        // thats when we start pulsating animation
        if answer == num1 + num2 {
            //hide first instruction
            handleScene(label: instructionOneLabel, show: false)
            
            //hide second instruction
            handleScene(label: instructionTwoLabel , show: false)

            //show third instruction
            handleScene(label: instructionThreeLabel , show: true)
            
            showAllOptions()
            animateAllSwipedCells()
            //animate cells
            //containerViewOne.animateSwipedCells()
            //containerViewTwo.animateSwipedCells()
        }
    }
    
    func animateAllSwipedCells() {
        var indexToStartFrom = 0
        // Animate in first container
        indexToStartFrom = containerViewOne.cellCount! - containerViewOne.swipableCellCount
        for index in indexToStartFrom..<containerViewOne.cellCount!{
             let targetCell = containerViewOne.cellViews![index]
            addPulsatingAnimation(viewToAnimate: targetCell, containerView: containerViewOne, delay: 1)
        }
        
        // Animate in Second container
        indexToStartFrom = containerViewTwo.cellCount! - containerViewTwo.swipableCellCount
        for index in indexToStartFrom..<containerViewTwo.cellCount!{
            let targetCell = containerViewTwo.cellViews![index]
            addPulsatingAnimation(viewToAnimate: targetCell, containerView: containerViewTwo, delay: 1)
        }
    }
    
    func addPulsatingAnimation(viewToAnimate: UIView, containerView: ContainerView, delay: Double) {
        let trackLayer = CAShapeLayer()
        let frame = CGRect(x: getX(slideCounter: 1) - 1 , y: viewToAnimate.frame.minY - 1, width: containerView.cellWidth + 2, height: containerView.cellHeight + 2)
        let rectPAth = UIBezierPath(rect: frame)
        
        trackLayer.path = rectPAth.cgPath
        
        trackLayer.strokeColor = UIColor.green.cgColor
        trackLayer.lineWidth = 2
        trackLayer.fillColor = UIColor.clear.cgColor
        
        containerView.layer.addSublayer(trackLayer)
        
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0.4
        animation.toValue = 1.0
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount =  3
        animation.beginTime = CACurrentMediaTime() + delay
        
        trackLayer.add(animation, forKey: "pulse")
    }
    
    func generateTwoRandomNumbers() {
        num1 = Int(arc4random_uniform(4) + 1)
        num2 = Int(arc4random_uniform(3) + 1)
        print(num1)
        print(num2)
        //assign values to instructions
        instructionOneLabel.text = self.num1>1 ? "Can you swipe "+String(self.num1) + " cells to the right?" : "Can you swipe 1 cell to the right?"
         instructionTwoLabel.text = self.num2>1 ? "Can you swipe "+String(self.num2) + " cells to the right?" : "Can you swipe 1 cell to the right?"
    }
    
    // This method caps the number of cells that can be swiped in each container
    // i.e. num1 and num2 in each respective containers
    func setSwipableCells(){
        containerViewOne.setSwipableCells(count: num1)
        containerViewTwo.setSwipableCells(count: num2)
    }
    
    // modifies the scene by hiding and showing the instruction labels
    func handleScene(label: UILabel, show: Bool) {
        if show {
            UIView.animate(withDuration: 1, delay: 0.5, options: [.curveEaseOut], animations: {
                label.alpha = 1.0
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 1, animations: {
                label.alpha = 0.0
            }, completion: nil)
        }
    }
    
    func showAllOptions() {
        for index in 0..<optionButton.count{
            UIView.animate(withDuration: 0.25, delay: 0.5, options: [.curveEaseOut], animations:{
                self.optionButton[index].alpha = 1.0
            }, completion: nil)
        }
    }
}

