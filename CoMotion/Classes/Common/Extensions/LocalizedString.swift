//
//  String+Localized.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/19/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

extension String {
    
    static var com_start = {
        return NSLocalizedString("Start", comment: "Start")
    }()
    
    static var com_stop = {
        return NSLocalizedString("Stop", comment: "Stop")
    }()
    
}
