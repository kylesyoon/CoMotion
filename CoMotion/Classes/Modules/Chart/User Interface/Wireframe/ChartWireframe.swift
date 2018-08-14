//
//  ChartWireframe.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 8/14/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class ChartWireframe {
    
    var rootWireframe: RootWireframe?
    
    var chartPresenter: ChartPresenter?
    
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    var chartViewController: ChartViewController?
    
    var chartViewControllerFromStoryboard: ChartViewController? {
        guard let chartViewController = self.mainStoryboard.instantiateViewController(withIdentifier: String(describing: ChartViewController.self)) as? ChartViewController else {
            assertionFailure("Couldn't get ListViewController from Main storyboard.")
            return nil
        }
        
        return chartViewController
    }
    
    func setupInitialEmbeddedChartViewController() -> UINavigationController? {
        guard let chartViewController = chartViewControllerFromStoryboard else {
            assertionFailure("Couldn't initialize a ChartPresenter and ChartViewController")
            return nil
        }
        
        chartViewController.eventHandler = chartPresenter
        chartPresenter?.userInterface = chartViewController
        self.chartViewController = chartViewController
        
        let navigationController = UINavigationController(rootViewController: chartViewController)
        navigationController.tabBarItem = UITabBarItem(title: String.com_list,
                                                       image: nil,
                                                       selectedImage: nil)
        
        return navigationController
    }
    
}
