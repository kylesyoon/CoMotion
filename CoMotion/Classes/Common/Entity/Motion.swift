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
