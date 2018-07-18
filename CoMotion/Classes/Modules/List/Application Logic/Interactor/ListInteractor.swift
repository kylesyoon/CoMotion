//
//  ListInteractor.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/16/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class ListInteractor: ListInteractorInput, MotionManagerDelegate {
    
    weak var output: ListInteractorOutput?
    var motionManager: MotionManager
    
    init(motionManager: MotionManager) {
        self.motionManager = motionManager
        self.motionManager.delegate = self
    }
    
    // MARK: ListInteractorInput
    
    func startMotionUpdates() {
        self.motionManager.start()
    }
    
    func stopMotionUpdates() {
        self.motionManager.stop()
    }
    
    // MARK: MotionManagerDelegate
    
    func motionManager(_ motionManager: MotionManager, didUpdate deviceMotion: Motion) {
        self.output?.update(deviceMotion)
    }
    
}
