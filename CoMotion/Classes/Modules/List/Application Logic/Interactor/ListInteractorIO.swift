//
//  ListInteractorIO.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/17/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

protocol ListInteractorInput: class {
    
    func startMotionUpdates()
    func stopMotionUpdates()
    
}

protocol ListInteractorOutput: class {
    
    func update(_ motion: Motion)
    
}
