//
//  ListInteractorIO.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/17/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

protocol ListInteractorInput: class {
    
    func startRecordingMotion()
    func stopRecordingMotion()
    func deleteMotion(at indicies: [Int])
    func fetchRecordedMotion()
    
}

protocol ListInteractorOutput: class {
    
    func finishedRecording(_ motionData: [Motion])
    
}
