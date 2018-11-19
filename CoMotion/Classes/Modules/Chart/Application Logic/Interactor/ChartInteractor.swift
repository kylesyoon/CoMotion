//
//  ChartInteractor.swift
//  CoMotion
//
//  Created by Kyle Sejin Yoon on 11/19/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class ChartInteractor: ChartInteractorInput, MotionManagerDelegate {
    
    weak var output: ChartInteractorOutput?
    var motionManager: MotionManager
    
    init(motionManager: MotionManager) {
        self.motionManager = motionManager
        self.motionManager.delegate = self
    }
    
    // MARK: ChartInteractorInput
    
    func startRecordingMotion() {
        self.motionManager.start()
    }
    
    func stopRecordingMotion() {
        self.motionManager.stop()
    }
    
    func fetchRecordedMotion() -> [Motion] {
        return self.motionManager.recordedMotion
    }
    
    // MARK: MotionManagerDelegate
    
    func motionManager(_ motionManager: MotionManager, didFinishRecording deviceMotion: [Motion]) {
        output?.finishedRecording(deviceMotion)
    }
    
}
