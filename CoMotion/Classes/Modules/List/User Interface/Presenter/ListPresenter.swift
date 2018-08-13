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
        let attitudeItemData = ListItemData(title: .com_attitude,
                                            x: motion.attitude.roll.com_string,
                                            y: motion.attitude.pitch.com_string,
                                            z: motion.attitude.yaw.com_string)
        
        let rotationItemData = ListItemData(title: .com_rotationRate,
                                            x: motion.rotationRate.x.com_string,
                                            y: motion.rotationRate.y.com_string,
                                            z: motion.rotationRate.z.com_string)
        
        let gravityItemData = ListItemData(title: .com_gravity,
                                           x: motion.gravity.x.com_string,
                                           y: motion.gravity.y.com_string,
                                           z: motion.gravity.z.com_string)
        
        let accelerationItemData = ListItemData(title: .com_userAcceleration,
                                                x: motion.userAcceleration.x.com_string,
                                                y: motion.userAcceleration.y.com_string,
                                                z: motion.userAcceleration.z.com_string)
        
        // TODO: motion.heading
        
        let sectionData = ListSectionData(timestamp: "\(motion.timestamp)", items: [attitudeItemData,
                                                                                    rotationItemData,
                                                                                    gravityItemData,
                                                                                    accelerationItemData])
        
        self.userInterface?.addSectionDataToUserInterface(data: sectionData)
    }
    
    // MARK: ListModuleInterface
    
    func startMotionUpdates() {
        interactor?.startMotionUpdates()
    }
    
    func stopMotionUpdates() {
        interactor?.stopMotionUpdates()
    }
    
}
