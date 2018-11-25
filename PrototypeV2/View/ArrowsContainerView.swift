//
//  ArrowsContainerView.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-11-06.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ArrowsContainerView: UIView {

    let cellWidth:CGFloat = 20
    let cellGap:CGFloat = 6
    var arrowViews: [UIView]?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cellCount: Int? {
        didSet{
            // set up cells
            setUpCells()
        }
    }
    
    let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let arrowImage = UIImage(named: "up_down_arrow")?.withRenderingMode(.alwaysTemplate)
        arrowImageView.image = arrowImage
        arrowImageView.tintColor = .yellow
        return arrowImageView
    }()
    
    func setUpCells() {
        // if containerView not empty already, remove all cell views
        if !self.subviews.isEmpty{
            self.subviews.forEach { $0.removeFromSuperview() }
        }
        
        arrowViews = [UIView]()
        for _ in 0..<cellCount!{
            let arrowView = UIView()
            addArrow(arrowView: arrowView)
            arrowView.translatesAutoresizingMaskIntoConstraints = false
//            let randomNum = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
//            arrowView.backgroundColor = UIColor(red: randomNum, green: randomNum, blue:
            //randomNum, alpha: 1)
            addSubview(arrowView)
            arrowViews?.append(arrowView)
        }
        
        // constraints
        for index in 0..<cellCount!{
            if index == 0 {
                arrowViews?[index].anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .zero, size: .init(width: cellWidth, height: 0))
            }else{
                 arrowViews?[index].anchor(top: self.topAnchor, leading: nil, bottom: self.bottomAnchor, trailing: arrowViews?[index-1].leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: cellGap), size: .init(width: cellWidth, height: 0))
            }
        }
    }
    
    func addArrow(arrowView: UIView){
        let arrowImageView = UIImageView()
        arrowImageView.contentMode = .scaleAspectFill
        arrowImageView.clipsToBounds = true
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        let arrowImage = UIImage(named: "up_down")?.withRenderingMode(.alwaysTemplate)
        arrowImageView.image = arrowImage
        arrowImageView.tintColor = .yellow
        
        //let arrowImageView = self.arrowImageView
        arrowView.addSubview(arrowImageView)
        arrowImageView.centerXAnchor.constraint(equalTo: arrowView.centerXAnchor).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: arrowView.centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowImageView.heightAnchor.constraint(equalTo: arrowView.heightAnchor).isActive = true
    }
}
