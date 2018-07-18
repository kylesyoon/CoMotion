//
//  ListWireframe.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class ListWireframe {
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var listViewControllerFromStoryboard: UIViewController {
        return self.mainStoryboard.instantiateViewController(withIdentifier: String(describing: ListViewController.self))
    }
    
    func presentListInterface(from window: UIWindow) {

    }
}
