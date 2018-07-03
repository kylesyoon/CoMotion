//
//  MotionManager.swift
//  CoMotion WatchKit Extension
//
//  Created by Yoon, Kyle on 7/2/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import CoreMotion

class MotionManager {
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
        
        motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
            if let motion = motion {
                print(motion)
            }
        }
    }
    
    func stop() {
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.stopDeviceMotionUpdates()
    }
}
