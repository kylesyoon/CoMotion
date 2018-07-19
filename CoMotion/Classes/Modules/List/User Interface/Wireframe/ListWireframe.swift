//
//  ListWireframe.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class ListWireframe {
    
    var rootWireframe: RootWireframe?

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var listPresenter: ListPresenter?
    
    var listViewController: ListViewController?
    
    var listViewControllerFromStoryboard: ListViewController? {
        guard let listViewController = self.mainStoryboard.instantiateViewController(withIdentifier: String(describing: ListViewController.self)) as? ListViewController else {
            assertionFailure("Couldn't get ListViewController from Main storyboard.")
            return nil
        }
        
        return listViewController
    }
    
    func presentListInterface(from window: UIWindow) {
        guard let rootWireframe = rootWireframe, let listViewController = listViewControllerFromStoryboard else {
            return
        }
        
        listViewController.eventHandler = self.listPresenter
        self.listPresenter?.userInterface = listViewController
        self.listViewController = listViewController
        
        rootWireframe.showRootViewController(listViewController, in: window)
    }
    
}
