//
//  ProgressController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-17.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ProgressDataView: UIView {
    
    let moduletitleHeight: CGFloat = 30
    let dataLabelHeight: CGFloat = 30
    
    lazy var totalHeight: CGFloat = {
        return moduletitleHeight + 3 * dataLabelHeight
    }()
    
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
        //label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Montserrat-Regular", size: 24)
        label.textColor = UIColor(rgb: Color.textPrimary.rawValue, alpha: 1)
        return label
    }()
    
    let dateLabels: [UILabel] = {
       var dateLabels = [UILabel]()
        for _ in 0..<3{
            let dateLabel = UILabel()
            dateLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
            dateLabel.textAlignment = .center
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
            timeSpendLabel.translatesAutoresizingMaskIntoConstraints = false
            timeSpendLabel.textColor = UIColor.init(rgb: Color.textPrimary.rawValue, alpha: 1)
            timeSpentLabels.append(timeSpendLabel)
        }
        return timeSpentLabels
    }()
    
    let dividerLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(rgb: Color.wineRed.rawValue, alpha: 1)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    func setupViews() {
        addSubview(moduleTitleLabel)
        for index in 0..<3{
            addSubview(dateLabels[index])
            addSubview(timeSpentLabels[index])
        }
        addSubview(dividerLineView)
        
        // add constraints
        moduleTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        moduleTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        moduleTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        moduleTitleLabel.heightAnchor.constraint(equalToConstant: moduletitleHeight).isActive = true
    
        for index in 0..<3{
            if index == 0 {
                // for date
                dateLabels[index].anchor(top: moduleTitleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: self.frame.width/2, height: dataLabelHeight))
                
                 timeSpentLabels[index].anchor(top: moduleTitleLabel.bottomAnchor, leading: dateLabels[index].trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: self.frame.width/2, height: dataLabelHeight))
            }else{
                dateLabels[index].anchor(top: dateLabels[index - 1].bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: self.frame.width/2, height: dataLabelHeight))
                
                timeSpentLabels[index].anchor(top: timeSpentLabels[index - 1].bottomAnchor, leading: dateLabels[index].trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: self.frame.width/2, height: dataLabelHeight))
            }
        }
        
        dividerLineView.anchor(top: moduleTitleLabel.bottomAnchor, leading: moduleTitleLabel.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 3 * dataLabelHeight + 8, left: 0, bottom: 8, right: 0), size: .init(width: 60, height: 2))
    }
    
}

class ProgressController: UIViewController {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.backgroundColor = .lightGray
        return scrollView

    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let progressDataView: ProgressDataView = {
        let dataView = ProgressDataView()
        dataView.backgroundColor = .gray
        dataView.translatesAutoresizingMaskIntoConstraints = false
        return dataView
    }()
    
    let moduleProgressDataViews: [ProgressDataView] = {
       var arr = [ProgressDataView]()
        for index in 0..<ModuleType.allValues.count{
            let dff = ProgressDataView()
            dff.translatesAutoresizingMaskIntoConstraints = false
            arr.append(dff)
        }
        return arr
    }()
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupViews()
        fetchDataFromFirebase()
    }
    
    func fetchDataFromFirebase() {
        ref = Database.database().reference()
        if let user = Auth.auth().currentUser{
            
            for index in 0..<ModuleType.allValues.count {
                mapProgressData(user: user,
                                moduleName: ModuleType.allValues[index].rawValue,
                                index: index)
            }
        }
        
    }
    
    func setupViews() {
        // scrollview setup
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 750).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        
        // progress data views setup
        for index in 0..<ModuleType.allValues.count{

            contentView.addSubview(moduleProgressDataViews[index])
            moduleProgressDataViews[index].moduleTitleLabel.text = ModuleType.allValues[index].rawValue
    
            if index == 0{
                moduleProgressDataViews[index].topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true

            }else{
                moduleProgressDataViews[index].topAnchor.constraint(equalTo: moduleProgressDataViews[index - 1].bottomAnchor, constant: 8).isActive = true

            }
            moduleProgressDataViews[index].leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            moduleProgressDataViews[index].trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            moduleProgressDataViews[index].heightAnchor.constraint(greaterThanOrEqualToConstant: moduleProgressDataViews[index].totalHeight).isActive = true
        }
    }
    
    func mapProgressData(user : User, moduleName: String, index: Int) {
        ref?.child("users").child(user.uid).child("modules").child(moduleName).child("progress").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            if value == nil{
                print("Value is nil, so dont proceed further")
                return
            }
            if let timeStamp1 = value!["timestamp1"] as? NSDictionary{
                let date1 = (timeStamp1["date"] as? Int64)!
                let duration1 = (timeStamp1["duration"] as? Int)!
                
                if date1 != 0{
                    self.moduleProgressDataViews[index].dateLabels[0].text = Utility.getReadableDate(timeInMillis: date1)
                }else
                {
                    self.moduleProgressDataViews[0].dateLabels[0].text = "No date"
                    //self.countingDateOne.isHidden = true
                }
                
                if duration1 != 0{
                    
                    self.moduleProgressDataViews[index].timeSpentLabels[0].text = Utility.secondsToHoursMinutesSeconds(seconds: duration1)
                }else
                {
                    self.moduleProgressDataViews[0].timeSpentLabels[0].text = "No time"
                    //self.countingDurationOne.isHidden = true
                }
                
            }
            
            if let timeStamp2 = value!["timestamp2"] as? NSDictionary{
                let date2 = (timeStamp2["date"] as? Int64)!
                let duration2 = (timeStamp2["duration"] as? Int)!
                
                if date2 != 0{
                    self.moduleProgressDataViews[index].dateLabels[1].text = Utility.getReadableDate(timeInMillis: date2)
                }else{
                    self.moduleProgressDataViews[index].dateLabels[1].text = "No date"
                    //self.countingDateTwo.isHidden = true
                }
                
                if duration2 != 0{
                    
                    self.moduleProgressDataViews[index].timeSpentLabels[1].text = Utility.secondsToHoursMinutesSeconds(seconds: duration2)
                }else
                {
                     self.moduleProgressDataViews[index].timeSpentLabels[1].text = "No time"
                    //self.countingDurationTwo.isHidden = true
                }
                
            }
            
            if let timeStamp3 = value!["timestamp3"] as? NSDictionary{
                let date3 = (timeStamp3["date"] as? Int64)!
                let duration3 = (timeStamp3["duration"] as? Int)!
                
                if date3 != 0{
                    self.moduleProgressDataViews[index].dateLabels[2].text = Utility.getReadableDate(timeInMillis: date3)
                }else{
                    self.moduleProgressDataViews[index].dateLabels[2].text = "No time"
                    
                }
                
                if duration3 != 0{
                    
                    self.moduleProgressDataViews[index].timeSpentLabels[2].text = Utility.secondsToHoursMinutesSeconds(seconds: duration3)
                }else{
                    self.moduleProgressDataViews[index].timeSpentLabels[2].text = "No time"
                }
                
            }
            
        })
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
