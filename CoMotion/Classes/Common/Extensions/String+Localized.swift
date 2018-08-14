//
//  String+Localized.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/19/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

extension String {
    
    static var com_list = {
        return NSLocalizedString("List", comment: "List")
    }()
    
    static var com_chart = {
        return NSLocalizedString("Chart", comment: "Chart")
    }()
    
    static var com_start = {
        return NSLocalizedString("Start", comment: "Start")
    }()
    
    static var com_stop = {
        return NSLocalizedString("Stop", comment: "Stop")
    }()
    
    static var com_attitude = {
        return NSLocalizedString("Attitude", comment: "Attitude")
    }()
    
    static var com_rotationRate = {
        return NSLocalizedString("Rotation Rate", comment: "Rotation Rate")
    }()
    
    static var com_gravity = {
       return NSLocalizedString("Gravity", comment: "Gravity")
    }()
    
    static var com_userAcceleration = {
       return NSLocalizedString("User Acceleration", comment: "User Acceleration")
    }()
}
