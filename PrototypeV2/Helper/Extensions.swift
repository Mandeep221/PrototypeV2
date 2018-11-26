//
//  Extensions.swift
//  PrototypeV2
//
//  Created by Mandeep Sarangal on 2018-10-08.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func scale(fromValue: CGFloat, toValue: CGFloat) {
        let scaleSpringAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleSpringAnimation.fromValue = fromValue
        scaleSpringAnimation.toValue = toValue
//        scaleSpringAnimation.initialVelocity = 1
//        scaleSpringAnimation.damping = 2
        //scaleSpringAnimation.autoreverses = true
        scaleSpringAnimation.repeatCount = 0
        scaleSpringAnimation.duration = 1
        layer.add(scaleSpringAnimation, forKey: "transform.scale")
    }
    
    // shake view
    func shake() {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 3
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(shakeAnimation, forKey: "position")
    }
    
   
    // Autolayout constraints
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
       
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
    // drop shadow
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -4, height: 1)
        layer.shadowRadius = 10
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}

extension UIColor{
    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

// For Padding in UITextField
extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}

// for color of nav bar bottom border
extension UIColor {
    func as1ptImage() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let ctx = UIGraphicsGetCurrentContext(){
            self.setFill()
            ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }
        
        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}

extension NSLayoutAnchor {
    @objc func constraintEqualToAnchor(anchor: NSLayoutAnchor!, constant:CGFloat, identifier:String) -> NSLayoutConstraint! {
        let constraint = self.constraint(equalTo: anchor, constant:constant)
        constraint.identifier = identifier
        return constraint
    }
}

extension UIView {
    func constraint(withIdentifier:String) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier }.first
    }
}

extension Int {
    public var asWord: String {
        let numberValue = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter.string(from: numberValue)!
    }
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

