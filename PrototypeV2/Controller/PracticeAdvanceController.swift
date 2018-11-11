//
//  PracticeAdvanceControllerViewController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-10.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class InstructionCellContainerView: UIView {
    
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
        
        
        cellsContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        cellsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        cellsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        cellsContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        anchorForContainer.anchor(top: cellsContainerView.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: (cellsContainerView.cellHeight - cellsContainerView.anchorHeight)/2, left: 0, bottom: (cellsContainerView.cellHeight - cellsContainerView.anchorHeight)/2, right: 0), size: .init(width: 0, height: 2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PracticeAdvanceController: UIViewController {

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
    
    var rows: [InstructionCellContainerView]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav bar
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = []
        
        //#2C163B
        view.backgroundColor = UIColor(rgb: 0x2C163B, alpha: 1)
        
        view.addSubview(moduleSubTitleLabel)
        view.addSubview(moduleTitleLabel)
        
        // constraints
        moduleSubTitleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 20))
        
        moduleTitleLabel.anchor(top: moduleSubTitleLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 40))
    
        // Generate 2 randome numbers, for rows and colums
        numRow = Int(arc4random_uniform(3) + 1)
        numColumn = Int(arc4random_uniform(2) + 1)
        numColumn = numColumn==1 ? 2:numColumn
        
        //print(numRow, numColumn)
        
        rows = [InstructionCellContainerView]()

        // generate number of cell containers required based of number of rows,
        // number of cells in each cell container would be the numColumn generated
        for index in 0..<3 {
            let iCellContainerView = InstructionCellContainerView()
            iCellContainerView.translatesAutoresizingMaskIntoConstraints = false
            //iCellContainerView.cellsContainerView.cellCount = numColumn
            // add views
            view.addSubview(iCellContainerView)
            iCellContainerView.cellsContainerView.cellCount = 7
            
            // add constraints
            iCellContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            iCellContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            if index == 0{
                iCellContainerView.topAnchor.constraint(equalTo: moduleTitleLabel.bottomAnchor).isActive = true
            }else{
                iCellContainerView.topAnchor.constraint(equalTo: rows![index-1].bottomAnchor).isActive = true
            }
            iCellContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
            rows?.append(iCellContainerView)
        }
    }

    
}
