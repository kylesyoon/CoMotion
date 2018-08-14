//
//  RootWireframe.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class RootWireframe {
    
    var tabBarController: UITabBarController?
    
    func showViewControllers(_ viewControllers: [UIViewController], in window: UIWindow) {
        let tabBarController = UITabBarController()
        
//        guard let rootViewController = navigationControllers.first as? UITabBarControllerDelegate else {
//            assertionFailure("Navigation controller is missing a root view controller that conforms to UITabBarControllerDelegate.")
//            return
//        }
        
//        tabBarController.delegate = rootViewController
        tabBarController.setViewControllers(viewControllers, animated: true)
        self.tabBarController = tabBarController
        
        window.rootViewController = self.tabBarController
    }
    
}
