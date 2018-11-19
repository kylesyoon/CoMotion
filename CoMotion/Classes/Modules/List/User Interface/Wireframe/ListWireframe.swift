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
    var chartWireframe: ChartWireframe?

    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    var listPresenter: ListPresenter?
    
    var listViewController: ListViewController?
    
    var listViewControllerFromStoryboard: ListViewController? {
        guard let listViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: ListViewController.self)) as? ListViewController else {
            assertionFailure("Couldn't get ListViewController from Main storyboard.")
            return nil
        }
        
        return listViewController
    }
    
    func presentListInterface(from window: UIWindow) {
        guard
            let rootWireframe = rootWireframe,
            let listViewController = listViewControllerFromStoryboard,
            let chartWireframe = chartWireframe,
            let chartNavigationController = chartWireframe.setupInitialEmbeddedChartViewController() else {
                return
        }
        
        listViewController.eventHandler = listPresenter
        listPresenter?.userInterface = listViewController
        self.listViewController = listViewController
        
        var tabs = [UINavigationController]()
        
        let listNavigationController = UINavigationController(rootViewController: listViewController)
        listNavigationController.tabBarItem = UITabBarItem(title: String.com_list,
                                                           image: nil,
                                                           selectedImage: nil)
        tabs.append(listNavigationController)
        tabs.append(chartNavigationController)

        rootWireframe.showViewControllers(tabs, in: window)
    }
    
    func presentChartInterface() {
        
    }
    
}
