//
//  AppDependencies.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class AppDependencies {
    
    var listWireframe: ListWireframe?
    
    init() {
        self.configureDependencies()
    }
    
    func setRootViewController(into window: UIWindow) {
        self.listWireframe?.presentListInterface(from: window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireframe()
        let motionManager = MotionManager()
        
        let chartInteractor = ChartInteractor(motionManager: motionManager)
        let chartPresenter = ChartPresenter()
        let chartWireframe = ChartWireframe()
        
        chartInteractor.output = chartPresenter
        chartPresenter.interactor = chartInteractor
        chartWireframe.rootWireframe = rootWireframe
        chartWireframe.chartPresenter = chartPresenter
        
        let listInteractor = ListInteractor(motionManager: motionManager)
        let listPresenter = ListPresenter()
        let listWireframe = ListWireframe()
        
        listInteractor.output = listPresenter
        listPresenter.interactor = listInteractor
        listWireframe.rootWireframe = rootWireframe
        listWireframe.chartWireframe = chartWireframe
        listWireframe.listPresenter = listPresenter
        self.listWireframe = listWireframe
    }
    
}
