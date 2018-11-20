//
//  MotionManager.swift
//  CoMotion WatchKit Extension
//
//  Created by Yoon, Kyle on 7/2/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import CoreMotion

// TODO: Create persistence store

protocol MotionManagerDelegate: class {
    
    /// Lets the delegate know that the MotionManager has finished recording and provides the recorded device motion.
    ///
    /// - Parameters:
    ///   - motionManager: the instance recording the motion data
    ///   - deviceMotion: the recorded motion data
    func motionManager(_ motionManager: MotionManager, didFinishRecording deviceMotion: [Motion])
    
}

class MotionManager {
    
    weak var delegate: MotionManagerDelegate?
    
    /// The current motion data
    var recordedMotion = [Motion]()
    
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
            strongSelf.recordedMotion.append(deviceMotion.com_motionValue)
        }
        #endif
    }
    
    func stop() {
        #if targetEnvironment(simulator)
        stopMock()
        #else
        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.stopDeviceMotionUpdates()
        delegate?.motionManager(self, didFinishRecording: recordedMotion)
        #endif
    }
    
    deinit {
        stop()
    }
    
    private func startMock() {
        var index = 0
        mockTimer = Timer.scheduledTimer(withTimeInterval: motionManager.deviceMotionUpdateInterval,
                                         repeats: true) { timer in
                                            let timeInterval = Double(index) * Double(timer.timeInterval)
                                            index += 1
                                            let sinSignal = sin(timeInterval * 10)
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
                                            
                                            self.recordedMotion.append(motion)
        }
        mockTimer?.fire()
    }
    
    private func stopMock() {
        mockTimer?.invalidate()
        mockTimer = nil
        delegate?.motionManager(self, didFinishRecording: recordedMotion)
    }
    
}


