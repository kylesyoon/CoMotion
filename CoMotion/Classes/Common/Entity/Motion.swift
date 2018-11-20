//
//  Motion.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/16/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

// TODO: Does magnetic field matter?

struct Motion: Codable {
    
    let attitude: Attitude
    let rotationRate: Coordinates3D
    let gravity: Coordinates3D
    let userAcceleration: Coordinates3D
    let heading: Double
    let timestamp: Double
    
    enum PropertyKeys: String, CaseIterable {
        case attitudeRoll = "Attitude Roll"
        case attitudePitch = "Attitude Pitch"
        case attitudeYaw = "Attitude Yaw"
        case rotationRateX = "Rotation Rate X"
        case rotationRateY = "Rotation Rate Y"
        case rotationRateZ = "Rotation Rate Z"
        case gravityX = "Gravity X"
        case gravityY = "Gravity Y"
        case gravityZ = "Gravity Z"
        case userAccX = "User Acc. X"
        case userAccY = "User Acc. Y"
        case userAccZ = "User Acc. Z"
        case heading = "Heading"
    }

    func property(key: PropertyKeys) -> Double {
        switch key {
        case .attitudeRoll:
            return self.attitude.roll
        case .attitudePitch:
            return self.attitude.pitch
        case .attitudeYaw:
            return self.attitude.yaw
        case .rotationRateX:
            return self.rotationRate.x
        case .rotationRateY:
            return self.rotationRate.y
        case .rotationRateZ:
            return self.rotationRate.z
        case .gravityX:
            return self.gravity.x
        case .gravityY:
            return self.gravity.y
        case .gravityZ:
            return self.gravity.z
        case .userAccX:
            return self.userAcceleration.z
        case .userAccY:
            return self.userAcceleration.y
        case .userAccZ:
            return self.userAcceleration.z
        case .heading:
            return self.heading
        }
    }
}

extension Motion: Equatable {
    
    static func == (lhs: Motion, rhs: Motion) -> Bool {
        return lhs.attitude == rhs.attitude
            && lhs.rotationRate == rhs.rotationRate
            && lhs.gravity == rhs.gravity
            && lhs.userAcceleration == rhs.userAcceleration
            && lhs.heading == rhs.heading
            && lhs.timestamp == rhs.timestamp
    }
    
}

struct Attitude: Codable {
    
    let roll: Double
    let pitch: Double
    let yaw: Double
    
}

extension Attitude: Equatable {
    
    static func == (lhs: Attitude, rhs: Attitude) -> Bool {
        return lhs.roll == rhs.roll
            && lhs.pitch == rhs.pitch
            && lhs.yaw == rhs.yaw
    }
    
}

struct Coordinates3D: Codable {
    
    let x: Double
    let y: Double
    let z: Double
    
}

extension Coordinates3D: Equatable {
    
    static func == (lhs: Coordinates3D, rhs: Coordinates3D) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
            && lhs.z == rhs.z
    }
    
}


