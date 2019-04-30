//
//  MainTabBarController.swift
//  Entertainment Hub
//
//  Created by Michael Lema on 2/23/19.
//  Copyright © 2019 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        // Browse
        let browseNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: HomeController())
        
        // Search
        let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // Library
        let libraryNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Library"), selectedImage: #imageLiteral(resourceName: "Library"), rootViewController: LibraryController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        // User Profile
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: UserProfileController())
        
        // Settings
        let settingsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Settings"), selectedImage: #imageLiteral(resourceName: "Settings"), rootViewController: SettingsController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        
        modifyTabBarAppearance()
        //viewControllers = [browseNavController, libraryNavController, userProfileNavController, settingsNavController]
        viewControllers = [browseNavController, searchNavController, userProfileNavController, settingsNavController]
        //viewControllers = [searchNavController, browseNavController, libraryNavController, userProfileNavController, settingsNavController]
    }
    
    fileprivate func modifyTabBarAppearance() {
        self.tabBar.barTintColor = UIColor.App.gray
        self.tabBar.tintColor = UIColor.App.orange
    }
    
    
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.barTintColor = UIColor.App.gray
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}


extension MainTabBarController: UITabBarControllerDelegate {
    
}
