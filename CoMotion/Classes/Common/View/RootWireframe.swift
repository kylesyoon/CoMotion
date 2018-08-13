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
        let rootNavigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = rootNavigationController
    }
    
}
