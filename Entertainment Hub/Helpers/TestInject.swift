//
//  TestInject.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    #if DEBUG
    @objc func injected() {
        
        if self is UITabBarController == false {
            for subview in self.view.subviews {
                subview.removeFromSuperview()
            }
            for sublayer in self.view.layer.sublayers ?? [] {
                sublayer.removeFromSuperlayer()
            }
        }
        
        self.awakeFromNib()
        self.loadView()
        self.viewDidLoad()
        self.reloadInputViews()
        
        if self is UITableViewController, let tableViewController = self as? UITableViewController {
            tableViewController.tableView.reloadData()
        }
    }
    #endif
}
