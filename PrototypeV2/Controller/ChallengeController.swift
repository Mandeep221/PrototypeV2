//
//  ChallengeController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-21.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ChallengeController: UIViewController {

    var moduleType: String?
    
    let numViewPerRow = 8
    let numViewPerColumn = 7
    lazy var totalNumOfCells = numViewPerRow * numViewPerColumn
    var cells = [String: UIView]()
    
    var circularCellsIndices: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        circularCellsIndices = [Int]()
        generateCircularCellIndices()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        for j in 0...numViewPerColumn {
            for i in 0...numViewPerRow {
                let cellView = UIView()
                cellView.backgroundColor = Utility.randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellTap)))
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                view.addSubview(cellView)
                let key = "\(i)|\(j)"
                
                if (circularCellsIndices?.contains(((i+1) * (j+1))))!{
                    cellView.layer.cornerRadius = width/2
                }
                cells[key] = cellView
            }
        }
        
    }
    
    func generateCircularCellIndices(){
        for _ in 0..<7{
            let num = generateRandomNumber()
            circularCellsIndices?.append(num)
        }
    }
    
    func generateRandomNumber() -> Int{
        var randomInt: Int = -1
        while true{
            randomInt = Int.random(in: 1..<totalNumOfCells+1)
            if !(circularCellsIndices?.contains(randomInt))!{
                break
            }
        }
        return randomInt
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
