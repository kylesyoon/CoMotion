//
//  RootWireframe.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class RootWireframe {
    
    func showRootViewController(_ viewController: UIViewController, in window: UIWindow) {
        guard let navigationController = rootNavigationController(in: window) else {
            return
        }
        
        navigationController.viewControllers = [viewController]
    }
    
    func rootNavigationController(in window: UIWindow) -> UINavigationController? {
        guard let rootNavigationController = window.rootViewController as? UINavigationController else {
            assertionFailure("Couldn't get root navigation controller from window.")
            return nil
        }
        
        return rootNavigationController
    }
    
}
