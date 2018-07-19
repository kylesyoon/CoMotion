//
//  ListPresenter.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class ListPresenter: ListInteractorOutput, ListModuleInterface {
    
    var interactor: ListInteractorInput?
    var userInterface: ListViewInterface?
    
    // MARK: ListInteractorOutput
    
    func update(_ motion: Motion) {
        let attitudeString = "Attitude: Roll \(motion.attitude.roll) Pitch \(motion.attitude.pitch) Yaw \(motion.attitude.yaw)"
        let rotationRateString = "Rotation Rate: X \(motion.rotationRate.x) Y \(motion.rotationRate.y) Yaw \(motion.rotationRate.z)"
        let gravityString = "Gravity: X \(motion.gravity.x) Y \(motion.gravity.y) Yaw \(motion.gravity.z)"
        let userAccel = "Gravity: X \(motion.userAcceleration.x) Y \(motion.userAcceleration.y) Yaw \(motion.userAcceleration.z)"
        let heading = "Heading: \(motion.heading)"
        
        let displayStrings = [attitudeString, rotationRateString, gravityString, userAccel, heading]
        let title = displayStrings.joined(separator: "\n")
        
        self.userInterface?.addMotionToUserInterface(motion: MotionListDisplayData(title: title, timestamp: "\(motion.timestamp)"))
    }
    
    // MARK: ListModuleInterface
    
    func startMotionUpdates() {
        interactor?.startMotionUpdates()
    }
    
    func stoptMotionUpdates() {
        interactor?.stopMotionUpdates()
    }
    
}
