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

struct Attitude: Codable {
    
    let roll: Double
    let pitch: Double
    let yaw: Double
    
}

struct Coordinates3D: Codable {
    
    let x: Double
    let y: Double
    let z: Double
    
}
