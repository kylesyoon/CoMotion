//
//  ChartInteractorIO.swift
//  CoMotion
//
//  Created by Kyle Sejin Yoon on 11/19/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

protocol ChartInteractorInput: class {
    
    func startRecordingMotion()
    func stopRecordingMotion()
    func fetchRecordedMotion() -> [Motion]
    
}

protocol ChartInteractorOutput: class {
    
    func finishedRecording(_ motionData: [Motion])
    
}
