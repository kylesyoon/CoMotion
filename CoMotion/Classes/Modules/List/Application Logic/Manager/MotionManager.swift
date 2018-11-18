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
    
    private var mockTimer: Timer?
    
    func start() {
        #if targetEnvironment(simulator)
        startMock()
        #else
        guard motionManager.isDeviceMotionAvailable else {
            print("Device Motion is not available.")
            return
        }
        
        motionManager.startDeviceMotionUpdates(to: queue) { [weak self] (deviceMotion, error) in
            guard let strongSelf = self, let deviceMotion = deviceMotion else { return }
            print(deviceMotion)
            strongSelf.delegate?.motionManager(strongSelf, didUpdate: deviceMotion.com_motionValue)
        }
        #endif
    }
    
    func stop() {
        #if targetEnvironment(simulator)
        stopMock()
        #else
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.stopDeviceMotionUpdates()
        #endif
    }
    
    deinit {
        stop()
    }
    
    private func startMock() {
        let now = Date()
        mockTimer = Timer.scheduledTimer(withTimeInterval: motionManager.deviceMotionUpdateInterval,
                                         repeats: true) { timer in
                                            let timeInterval = timer.fireDate.timeIntervalSince(now)
                                            let sinSignal = sin(timeInterval)
                                            let attitude = Attitude(roll: sinSignal,
                                                                    pitch: sinSignal,
                                                                    yaw: sinSignal)
                                            let rotRate = Coordinates3D(x: sinSignal,
                                                                        y: sinSignal,
                                                                        z: sinSignal)
                                            let gravity = Coordinates3D(x: sinSignal,
                                                                        y: sinSignal,
                                                                        z: sinSignal)
                                            let userAcc = Coordinates3D(x: sinSignal,
                                                                        y: sinSignal,
                                                                        z: sinSignal)
                                            let motion = Motion(attitude: attitude,
                                                                rotationRate: rotRate,
                                                                gravity: gravity,
                                                                userAcceleration: userAcc,
                                                                heading: sinSignal,
                                                                timestamp: timeInterval)
                                            self.delegate?.motionManager(self, didUpdate: motion)
        }
        mockTimer?.fire()
    }
    
    private func stopMock() {
        mockTimer?.invalidate()
        mockTimer = nil
    }
    
}


