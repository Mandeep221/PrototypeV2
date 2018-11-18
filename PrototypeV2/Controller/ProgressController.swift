//
//  ProgressController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-17.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ProgressDataView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let moduleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Counting"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        return label
    }()
    
    let dateLabels: [UILabel] = {
       var dateLabels = [UILabel]()
        for _ in 0..<3{
            let dateLabel = UILabel()
            dateLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
            dateLabel.textAlignment = .center
            dateLabel.backgroundColor = .yellow
            dateLabel.text = "November 17, 2018"
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
            dateLabels.append(dateLabel)
        }
        return dateLabels
    }()
    
    let timeSpentLabels: [UILabel] = {
        var timeSpentLabels = [UILabel]()
        for _ in 0..<3{
            let timeSpendLabel = UILabel()
            timeSpendLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
            timeSpendLabel.textAlignment = .center
            timeSpendLabel.text = "30 mins"
            timeSpendLabel.backgroundColor = .green
            timeSpendLabel.translatesAutoresizingMaskIntoConstraints = false
            timeSpendLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
            timeSpentLabels.append(timeSpendLabel)
        }
        return timeSpentLabels
    }()
    
    func setupViews() {
        addSubview(moduleTitleLabel)
        for index in 0..<3{
            addSubview(dateLabels[index])
            addSubview(timeSpentLabels[index])
        }
        
        // add constraints
        moduleTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        moduleTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        moduleTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        moduleTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        for index in 0..<3{
            if index == 0 {
                // for date
                dateLabels[index].anchor(top: moduleTitleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: self.frame.width/2, height: 40))
                
                 timeSpentLabels[index].anchor(top: moduleTitleLabel.bottomAnchor, leading: dateLabels[index].trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: self.frame.width/2, height: 40))
            }else{
                dateLabels[index].anchor(top: dateLabels[index - 1].bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: self.frame.width/2, height: 40))
                
                timeSpentLabels[index].anchor(top: timeSpentLabels[index - 1].bottomAnchor, leading: dateLabels[index].trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 16, right: 16), size: .init(width: self.frame.width/2, height: 40))
            }
        }
    }
    
}

class ProgressController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .red
        return scrollView
        
    }()
    
    let progressDataView: ProgressDataView = {
        let dataView = ProgressDataView()
        dataView.backgroundColor = .gray
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    let arr: [ProgressDataView] = {
       var arr = [ProgressDataView]()
        for _ in 0..<4{
            let dff = ProgressDataView()
            dff.backgroundColor = .gray
            arr.append(dff)
        }
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        //scrollView.addSubview(progressDataView)
        
        // add constraints
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
        
        for index in 0..<4{
            
            scrollView.addSubview(arr[index])
            
            if index == 0{
                arr[index].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
               
            }else{
                arr[index].topAnchor.constraint(equalTo: arr[index - 1].bottomAnchor).isActive = true
                
            }
            arr[index].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            arr[index].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            arr[index].heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true
        }
    }
    func setupNavBar() {
        self.edgesForExtendedLayout = []
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
