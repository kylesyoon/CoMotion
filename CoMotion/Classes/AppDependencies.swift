//
//  AppDependencies.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class AppDependencies {
    init() {
        
    }
    
    func configureDependencies() {
        let motionManager = MotionManager()
        let listInteractor = ListInteractor(motionManager: motionManager)
    }
}
