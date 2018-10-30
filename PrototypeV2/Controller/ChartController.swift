//
//  ChartController.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-29.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class ChartController: UIViewController {

    
    
    let barChart: BasicBarChart = {
        let chart = BasicBarChart()
        //chart.translatesAutoresizingMaskIntoConstraints = false
        chart.backgroundColor = .yellow
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(barChart)
        
        barChart.frame = view.frame
        // constraints
//        barChart.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        barChart.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        barChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        barChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        barChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        // set up graph
        
//        barChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        barChart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        barChart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        barChart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//
//
        
        barChart.dataEntries = generateBarEnteries()
        
    }

    func generateBarEnteries() -> [BarEntry] {
        
        var result: [BarEntry] = []
        
        for index in 0..<10{
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMM"
            var date = Date()
            date.addTimeInterval(TimeInterval(24*60*60*index))
            result.append(BarEntry(color: randomColor(), height: height, textValue: "\(value)", title: formatter.string(from: date)))
        }
        
        return result
    }
    
    fileprivate func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        
        return UIColor(red: red, green: blue, blue: green, alpha: 1)
    }

}
