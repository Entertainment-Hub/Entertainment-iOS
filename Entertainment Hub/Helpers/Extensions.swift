//
//  Extensions.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

//: Constraints
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


extension UIColor {
    
    struct App {
        // gray
        static let gray = UIColor(red:0.20, green:0.19, blue:0.23, alpha:1.00)
        
        static let darkGray = UIColor(red:0.09, green:0.07, blue:0.10, alpha:1.00)
        // blue
        static let blue = UIColor(red:0.01, green:0.70, blue:1.00, alpha:1.00)
        
        // light blue
        static let lightBlue = UIColor(red:0.21, green:0.81, blue:0.87, alpha:1.00)
        
        // green
        static let green = UIColor(red:0.01, green:0.73, blue:0.03, alpha:1.00)
        
        // light green
        static let lightGreen = UIColor(red:0.10, green:0.68, blue:0.57, alpha:1.00)
        
        // bright green
        static let brightGreen = UIColor(red:0.40, green:0.79, blue:0.13, alpha:1.00)
        
        // yellow
        static let yellow = UIColor(red:1.00, green:0.73, blue:0.00, alpha:1.00)
        
        // orange
        static let orange = UIColor(red:0.96, green:0.57, blue:0.13, alpha:1.00)
        
        // dark orange
        static let darkOrange = UIColor(red:1.00, green:0.37, blue:0.00, alpha:1.00)
        
        // pink
        static let pink = UIColor(red:1.00, green:0.01, blue:0.50, alpha:1.00)
        
        // purple
        static let purple = UIColor(red:0.73, green:0.18, blue:0.91, alpha:1.00)
        
        static let allColors = [App.blue,
                                App.green,
                                App.orange,
                                App.brightGreen,
                                App.pink,
                                App.yellow,
                                App.lightBlue,
                                App.purple,
                                App.lightGreen,
                                App.darkOrange]
    }
    
}
extension UINavigationController
{
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


//: Color
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 17, green: 154, blue: 237)
    }
}
