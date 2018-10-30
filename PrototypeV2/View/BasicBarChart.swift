
//
//  BasicBarChart.swift
//  BarChart
//
//  Created by Nguyen Vu Nhat Minh on 19/8/17.
//  Copyright © 2017 Nguyen Vu Nhat Minh. All rights reserved.
//

import UIKit

class BasicBarChart: UIView {
    
    /// the width of each bar
    let barWidth: CGFloat = 40.0
    
    /// space between each bar
    let space: CGFloat = 20.0
    
    /// space at the bottom of the bar to show the title
    private let bottomSpace: CGFloat = 40.0
    
    /// space at the top of each bar to show the value
    private let topSpace: CGFloat = 40.0
    
    /// contain all layers of the chart
    private let mainLayer: CALayer = CALayer()
    
    /// contain mainLayer to support scrolling
    private let scrollView: UIScrollView = UIScrollView()
    
    var dataEntries: [BarEntry]? = nil {
        didSet {
            mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
            
            if let dataEntries = dataEntries {
                scrollView.contentSize = CGSize(width: (barWidth + space)*CGFloat(dataEntries.count), height: self.frame.size.height)
                mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
                
                drawHorizontalLines()
                
                for i in 0..<dataEntries.count {
                    showEntry(index: i, entry: dataEntries[i])
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    private func showEntry(index: Int, entry: BarEntry) {
        /// Starting x postion of the bar
        let xPos: CGFloat = space + CGFloat(index) * (barWidth + space)
        
        /// Starting y postion of the bar
        let yPos: CGFloat = translateHeightValueToYPosition(value: entry.height)
        
        drawBar(xPos: xPos, yPos: yPos, color: entry.color)
        
        /// Draw text above the bar
        drawTextValue(xPos: xPos - space/2, yPos: yPos - 30, textValue: entry.textValue, color: entry.color)
        
        /// Draw text below the bar
        drawTitle(xPos: xPos - space/2, yPos: mainLayer.frame.height - bottomSpace + 10, title: entry.title, color: entry.color)
    }
    
    private func drawBar(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
        let barLayer = CALayer()
        barLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth, height: mainLayer.frame.height - bottomSpace - yPos)
        barLayer.backgroundColor = color.cgColor
        mainLayer.addSublayer(barLayer)
    }
    
    private func drawHorizontalLines() {
        self.layer.sublayers?.forEach({
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        })
        let horizontalLineInfos = [["value": Float(0.0), "dashed": false], ["value": Float(0.5), "dashed": true], ["value": Float(1.0), "dashed": false]]
        for lineInfo in horizontalLineInfos {
            let xPos = CGFloat(0.0)
            let yPos = translateHeightValueToYPosition(value: (lineInfo["value"] as! Float))
            let path = UIBezierPath()
            path.move(to: CGPoint(x: xPos, y: yPos))
            path.addLine(to: CGPoint(x: scrollView.frame.size.width, y: yPos))
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 0.5
            if lineInfo["dashed"] as! Bool {
                lineLayer.lineDashPattern = [4, 4]
            }
            lineLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
            self.layer.insertSublayer(lineLayer, at: 0)
        }
    }
    
    private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth+space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = textValue
        mainLayer.addSublayer(textLayer)
    }
    
    private func drawTitle(xPos: CGFloat, yPos: CGFloat, title: String, color: UIColor) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth + space, height: 22)
        textLayer.foregroundColor = color.cgColor
        textLayer.backgroundColor = UIColor.clear.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
        textLayer.fontSize = 14
        textLayer.string = title
        mainLayer.addSublayer(textLayer)
    }
    
    private func translateHeightValueToYPosition(value: Float) -> CGFloat {
        let height: CGFloat = CGFloat(value) * (mainLayer.frame.height - bottomSpace - topSpace)
        return mainLayer.frame.height - bottomSpace - height
    }
}

////
////  File.swift
////  PrototypeV2
////
////  Created by Mandeep Sarangal on 2018-10-29.
////  Copyright © 2018 Mandeep Sarangal. All rights reserved.
////
//
//import UIKit
//
//struct BarEntry {
//    let color: UIColor
//
//    /// Ranged from 0.0 to 1.0
//    let height: Float
//
//    /// To be shown on top of the bar
//    let textValue: String
//
//    /// To be shown at the bottom of the bar
//    let title: String
//}
//
//class BasicBarChart: UIView{
//
//    // width of each bar
//    let barWidth: CGFloat = 40.0
//
//    // horizontal gap between each bar
//    let barGap: CGFloat = 20.0
//
//    // space at the top to show values
//    let topSpace: CGFloat = 40.0
//
//    // space at the bottom to show chart name
//    let bottomSpace: CGFloat = 40.0
//
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        return scrollView
//    }()
//
//    private let mainLayer: CALayer = {
//        let layer = CALayer()
//        return layer
//    }()
//
//    var dataEnteries: [BarEntry]? = nil {
//        didSet{
//            mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
//
//            if let dataEnteries = dataEnteries {
//                scrollView.contentSize = CGSize(width: (barWidth + barGap) * CGFloat(dataEnteries.count), height: self.frame.size.height)
//                mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
//                 drawHorizontalLines()
//                for  index in 0..<dataEnteries.count{
//                    showEntry(index: index, entry: dataEnteries[index])
//                }
//
//            }
//        }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    convenience init() {
//        self.init(frame: CGRect.zero)
//        setupViews()
//    }
//
////    required init?(coder aDecoder: NSCoder) {
////        super.init(coder: aDecoder)
////        setupViews()
////    }
////
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupViews(){
//        scrollView.layer.addSublayer(mainLayer)
//        addSubview(scrollView)
//
//        // constraints
//       // scrollView.frame = self.frame
//    }
//
//    override func layoutSubviews() {
//         scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
//    }
//
//
//    func showEntry(index: Int, entry: BarEntry) {
//        // starting x position of the bar
//        let xPos: CGFloat = barGap + CGFloat(index) * (barWidth + barGap)
//
//        // starting y position of the bar
//        let yPos = translateHeightValueToYPosition(value: entry.height)
//
//        drawBar(xPos: xPos, yPos: yPos, color: entry.color)
//
//        // draw text above the bar
//        drawTextValue(xPos: xPos - barGap/2, yPos: yPos - 30, textValue: entry.textValue, color: entry.color)
//
//        // draw text below the bar
//        drawTitle(xPos: xPos - barGap/2, yPos: mainLayer.frame.height - bottomSpace + 10, title: entry.title, color: entry.color)
//
//
//    }
//
//    private func translateHeightValueToYPosition(value: Float) -> CGFloat {
//        let height: CGFloat = CGFloat(value) * (mainLayer.frame.height - bottomSpace - topSpace)
//        return mainLayer.frame.height - bottomSpace - height
//    }
//
//    // draw bar
//    private func drawBar(xPos: CGFloat, yPos: CGFloat, color: UIColor) {
//        let barLayer = CALayer()
//        barLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth, height: mainLayer.frame.height - bottomSpace - yPos)
//        barLayer.backgroundColor = color.cgColor
//        mainLayer.addSublayer(barLayer)
//    }
//
//
//    private func drawHorizontalLines() {
//        self.layer.sublayers?.forEach({
//            if $0 is CAShapeLayer {
//                $0.removeFromSuperlayer()
//            }
//        })
//        let horizontalLineInfos = [["value": Float(0.0), "dashed": false], ["value": Float(0.5), "dashed": true], ["value": Float(1.0), "dashed": false]]
//        for lineInfo in horizontalLineInfos {
//            let xPos = CGFloat(0.0)
//            let yPos = translateHeightValueToYPosition(value: (lineInfo["value"] as! Float))
//            let path = UIBezierPath()
//            path.move(to: CGPoint(x: xPos, y: yPos))
//            path.addLine(to: CGPoint(x: scrollView.frame.size.width, y: yPos))
//            let lineLayer = CAShapeLayer()
//            lineLayer.path = path.cgPath
//            lineLayer.lineWidth = 0.5
//            if lineInfo["dashed"] as! Bool {
//                lineLayer.lineDashPattern = [4, 4]
//            }
//            lineLayer.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
//            self.layer.insertSublayer(lineLayer, at: 0)
//        }
//    }
//
//    // add text value on top of bar
//    private func drawTextValue(xPos: CGFloat, yPos: CGFloat, textValue: String, color: UIColor) {
//        let textLayer = CATextLayer()
//        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth + barGap, height: 22)
//        textLayer.foregroundColor = color.cgColor
//        textLayer.backgroundColor = UIColor.clear.cgColor
//        textLayer.alignmentMode = kCAAlignmentCenter
//        textLayer.contentsScale = UIScreen.main.scale
//        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
//        textLayer.fontSize = 14
//        textLayer.string = textValue
//        mainLayer.addSublayer(textLayer)
//    }
//
//    private func drawTitle(xPos: CGFloat, yPos: CGFloat, title: String, color: UIColor) {
//        let textLayer = CATextLayer()
//        textLayer.frame = CGRect(x: xPos, y: yPos, width: barWidth + barGap, height: 22)
//        textLayer.foregroundColor = color.cgColor
//        textLayer.backgroundColor = UIColor.clear.cgColor
//        textLayer.alignmentMode = kCAAlignmentCenter
//        textLayer.contentsScale = UIScreen.main.scale
//        textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
//        textLayer.fontSize = 14
//        textLayer.string = title
//        mainLayer.addSublayer(textLayer)
//    }
//}

