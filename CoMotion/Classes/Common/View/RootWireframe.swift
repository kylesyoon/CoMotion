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
        tabBarController.setViewControllers(viewControllers, animated: true)
        self.tabBarController = tabBarController
        
        window.rootViewController = self.tabBarController
    }
    
}
