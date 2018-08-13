//
//  MotionManager.swift
//  CoMotion WatchKit Extension
//
//  Created by Yoon, Kyle on 7/2/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import CoreMotion

protocol MotionManagerDelegate: class {
    
    func motionManager(_ motionManager: MotionManager, didUpdate deviceMotion: Motion)
    
}

class MotionManager {
    
    weak var delegate: MotionManagerDelegate?
    
    let motionManager = CMMotionManager()
    let queue: OperationQueue = {
       let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "MotionManagerQueue"
        
        return queue
    }()

    func start() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device Motion is not available.")
            return
        }
        
        motionManager.startDeviceMotionUpdates(to: queue) { [weak self] (deviceMotion, error) in
            guard let strongSelf = self, let deviceMotion = deviceMotion else { return }
            print(deviceMotion)
            strongSelf.delegate?.motionManager(strongSelf, didUpdate: deviceMotion.com_motionValue)
        }
    }
    
    func stop() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.stopDeviceMotionUpdates()
    }
    
    deinit {
        stop()
    }
    
}
