//
//  PracticeAdvanceControllerViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-10.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class InstructionCellContainerView: UIView {
    
    var topAnchorForCells: NSLayoutConstraint?
    
    let anchorForContainer: UIView = {
        let abchorView = UIView()
        //abchorView.backgroundColor = UIColor.init(rgb: 0xF7CE3E)
        abchorView.backgroundColor = .yellow
        abchorView.translatesAutoresizingMaskIntoConstraints = false
        return abchorView
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.text = "Can you swipe two cells to the right?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 1
        return label
    }()
    
    let cellsContainerView: CellsContainerView = {
        let cv = CellsContainerView()
        cv.isUserInteractionEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(instructionLabel)
        self.addSubview(anchorForContainer)
        self.addSubview(cellsContainerView)
        
        // constraints
        instructionLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
        
        
        
        topAnchorForCells = cellsContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40)
        topAnchorForCells?.isActive = true
        
        cellsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        cellsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        cellsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        anchorForContainer.anchor(top: cellsContainerView.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: (cellsContainerView.cellHeight - cellsContainerView.anchorHeight)/2, left: 0, bottom: (cellsContainerView.cellHeight - cellsContainerView.anchorHeight)/2, right: 0), size: .init(width: 0, height: 2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PracticeAdvanceController: UIViewController, AVSpeechSynthesizerDelegate {
    var speechSynthesizer: AVSpeechSynthesizer?
    var requiredNumbersForOptions: [Int]?
    var possibleRowValues: [NSNumber]?
    var possibleColumnValues: [NSNumber]?
    var numData: NumberData?
    var rowsDone = 0
    var answer: Int = 0
    var moduleType: ModuleType? = nil {
        didSet{
            moduleTitleLabel.text = moduleType?.rawValue
        }
    }
    
    var numRow: Int = 0
    var numColumn: Int = 0
    
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
    
    lazy var instructionCellContainerView: UIView = {
        
       let instructionCellContainerView = UIView()
        return instructionCellContainerView
    }()
    
    let finalInstructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.numberOfLines = 2
        instructionLabel.textColor = .white
        instructionLabel.font = UIFont(name: "Montserrat-Regular", size: 16)
        instructionLabel.text = "Can you swipe two cells to the right?"
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.alpha = 0
        return instructionLabel
    }()
    
    var rows: [InstructionCellContainerView]?
    
    lazy var optionButtons: [DesignableOptionView] = {
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
        
       // delete()

        // set up core data
        if fetch() == 0 {
            setUpCoreData()
        }

        // nav bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = []
        
        //#2C163B
        view.backgroundColor = UIColor(rgb: 0x2C163B, alpha: 1)
        
        view.addSubview(moduleSubTitleLabel)
        view.addSubview(moduleTitleLabel)
        for index in 0...optionButtons.count - 1{
            view.addSubview(optionButtons[index])
        }
        view.addSubview(finalInstructionLabel)
        setConstraintsForOptions()
        
        // constraints
        moduleSubTitleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 20))
        
        moduleTitleLabel.anchor(top: moduleSubTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
    
        // Generate 2 randome numbers, for rows and colums
//        numRow = Int(arc4random_uniform(4) + 1)
//        numColumn = Int(arc4random_uniform(2) + 1)
//        numColumn = numColumn==1 ? 2:numColumn
        
        numRow = Int(truncating: numData!.arrNumRows[0])
        numColumn = Int(truncating: numData!.arrNumColumns[0])
        
        adjustArray()
        
        //print(numRow, numColumn)
        
        rows = [InstructionCellContainerView]()

        // generate number of cell containers required based of number of rows,
        // number of cells in each cell container would be the numColumn generated
        for index in 0..<numRow {
            let iCellContainerView = InstructionCellContainerView()
            iCellContainerView.translatesAutoresizingMaskIntoConstraints = false
            iCellContainerView.cellsContainerView.viewPracAdvRef = self
            iCellContainerView.cellsContainerView.cellCount = 7
            iCellContainerView.cellsContainerView.swipableCellCount = numColumn
            iCellContainerView.instructionLabel.alpha = 0
            // add views
            view.addSubview(iCellContainerView)
            
            // add constraints
            iCellContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            iCellContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            if index == 0{
                iCellContainerView.topAnchor.constraint(equalTo: moduleTitleLabel.bottomAnchor, constant: 20).isActive = true
            }else{
                iCellContainerView.topAnchor.constraint(equalTo: rows![index-1].bottomAnchor).isActive = true
            }
            iCellContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            rows?.append(iCellContainerView)
        }
        
        // initiate scene
        handleScene(label: rows![0].instructionLabel, show: true)
        requiredNumbersForOptions = [Int]()
    }

    
    func setConstraintsForOptions() {
        let optionOneButton = optionButtons[0]
        let optionTwoButton = optionButtons[1]
        let optionThreeButton = optionButtons[2]
        let optionFourButton = optionButtons[3]
        
        
        //#TODO: width does not make sense, but somehow works
        optionThreeButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        // #TODO: width does not make sense, but somehow works
        optionFourButton.anchor(top: nil, leading: optionThreeButton.trailingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 20, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionOneButton.anchor(top: nil, leading: view.leadingAnchor, bottom: optionThreeButton.topAnchor, trailing: nil, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        optionTwoButton.anchor(top: nil, leading: nil, bottom: optionFourButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width / 2 - 16 - 8, height: 64))
        
        // for the third instruction
        finalInstructionLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: optionOneButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 16, right: 16), size: .init(width: view.frame.width, height: 40))
        
    }
    
    // modifies the scene by hiding and showing the instruction labels
    func handleScene(label: UILabel, show: Bool) {
        if show {
            UIView.animate(withDuration: 0.5, delay: 0.5, options: [.curveEaseOut], animations: {
                label.alpha = 1.0
            }, completion: { (_) in
                self.textToSpeech(text: label.text!)
            })
        }else{
            UIView.animate(withDuration: 1, animations: {
                label.alpha = 0.0
            }, completion: nil)
        }
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
        let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
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
    
    // every time the required number of cells are swiped in each container,
    // this method updates the total number of cells swiped and stores it in the answer variable
    func updateTotalCellsSwiped(cellsSwiped: Int) {
        rowsDone += 1
        if rowsDone < numRow{
            let nextRowIndex = rowsDone
            handleScene(label: rows![nextRowIndex].instructionLabel, show: true)
            handleScene(label: rows![nextRowIndex - 1].instructionLabel, show: false)
        }else if rowsDone == numRow{
            removeGapBetweenBars()
            answer = numRow * numColumn
            handleScene(label: rows![numRow-1].instructionLabel, show: false)
            handleScene(label: finalInstructionLabel, show: true)
            handleAllOptions(visible: true)
        }
        
    }
    
    func removeGapBetweenBars() {
        for index in 0..<rows!.count{
            //row.topAnchorForCells?.constant = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.rows![index].transform = CGAffineTransform(translationX: 0, y: CGFloat(index * -30))
            }, completion: nil)
        }
    }
    
    func setUpCoreData() {
        numData = NumberData(context: PersistenceService.context)
        if let numData = numData {
            numData.arrNumRows = [3, 2, 5, 4, 3, 2, 5, 2, 3, 5, 2, 4, 5 ]
            numData.arrNumColumns = [1, 2, 3, 2, 3, 1, 2, 3]
            PersistenceService.saveContext()
        }
    }
    
    func fetch() -> Int{
        
        let request: NSFetchRequest<NumberData> =  NumberData.fetchRequest()
        request.returnsObjectsAsFaults = false
        do{
            let result: [NumberData] = try PersistenceService.context.fetch(request)
            if result.count > 0{
                numData = result[0]
//                print(result[0].arrNumRows)
//                print(result[0].arrNumColumns)
            }
            return result.count
        }catch{
            return -1
        }
       
    }
    
    func delete(){
        
        let request: NSFetchRequest<NumberData> =  NumberData.fetchRequest()
        request.returnsObjectsAsFaults = false
        do{
            let result: [NumberData] = try PersistenceService.context.fetch(request)
            for object in result {
                PersistenceService.context.delete(object)
                try PersistenceService.context.save()
                print("deleted")
            }
        }catch{
           
        }
    }
    
    func adjustArray() {
        // for row numbers
        var item0 = numData!.arrNumRows[0]
        for index in 0..<numData!.arrNumRows.count - 1 {
            numData!.arrNumRows[index] = numData!.arrNumRows[index+1]
        }
        numData!.arrNumRows[numData!.arrNumRows.count - 1] = (item0)
        
        // for column numbers
        item0 = numData!.arrNumColumns[0]
        for index in 0..<numData!.arrNumColumns.count - 1 {
            numData!.arrNumColumns[index] = numData!.arrNumColumns[index+1]
        }
        numData!.arrNumColumns[numData!.arrNumColumns.count - 1] = (item0)
        
        // save changes
        PersistenceService.saveContext()
        //fetch()
    }
    
    func textToSpeech(text: String) {
        if speechSynthesizer == nil{
            speechSynthesizer = AVSpeechSynthesizer()
            speechSynthesizer?.delegate = self
        }
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")  // Samantha, Karen, Tessa
        speechSynthesizer!.speak(utterance)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1), range: characterRange)
        
        for row in rows!{
            if row.instructionLabel.alpha == 1.0{
                row.instructionLabel.attributedText = mutableAttributedString
            }
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        for row in rows!{
            if row.instructionLabel.alpha == 1.0{
                row.instructionLabel.attributedText = NSAttributedString(string: utterance.speechString)
                row.cellsContainerView.ladyDidFinishSpeaking()
            }
        }
        speechSynthesizer = nil
    }
}
