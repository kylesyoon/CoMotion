//
//  CMDeviceMotion+DictionaryValue.swift
//  CoMotion WatchKit Extension
//
//  Created by Yoon, Kyle on 7/3/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import CoreMotion

extension CMDeviceMotion {
    
    var dictionaryValue: [String: Any] {
        return [
            "timestamp": Double(self.timestamp),
            "attitude": ["roll": self.attitude.roll,
                         "pitch": self.attitude.pitch,
                         "yaw": self.attitude.yaw],
            "rotationRate": ["x": self.rotationRate.x,
                             "y": self.rotationRate.y,
                             "z": self.rotationRate.z],
            "gravity": ["x": self.gravity.x,
                        "y": self.gravity.y,
                        "z": self.gravity.z],
            "userAcceleration": ["x": self.userAcceleration.x,
                                 "y": self.userAcceleration.y,
                                 "z": self.userAcceleration.z],
            "heading": self.heading,
            "timestamp": self.timestamp
        ]
    }
    
    var motionValue: Motion {
        let attitude = Attitude(roll: self.attitude.roll,
                                pitch: self.attitude.pitch,
                                yaw: self.attitude.yaw)
        let rotRate = Coordinates3D(x: self.rotationRate.x,
                                    y: self.rotationRate.y,
                                    z: self.rotationRate.z)
        let gravity = Coordinates3D(x: self.gravity.x,
                                    y: self.gravity.y,
                                    z: self.gravity.z)
        let userAcc = Coordinates3D(x: self.userAcceleration.x,
                                    y: self.userAcceleration.y,
                                    z: self.userAcceleration.z)
        return Motion(attitude: attitude,
                      rotationRate: rotRate,
                      gravity: gravity,
                      userAcceleration: userAcc,
                      heading: self.heading,
                      timestamp: self.timestamp)
    }
    
}
