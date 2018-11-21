//
//  ListInteractor.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/16/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class ListInteractor: ListInteractorInput, MotionManagerDelegate {
    
    weak var output: ListInteractorOutput?
    var motionManager: MotionManager
    
    init(motionManager: MotionManager) {
        self.motionManager = motionManager
        self.motionManager.delegate = self
    }
    
    // MARK: ListInteractorInput
    
    func startRecordingMotion() {
        self.motionManager.start()
    }
    
    func stopRecordingMotion() {
        self.motionManager.stop()
    }
    
    func deleteMotion(at indicies: [Int]) {
        self.motionManager.delete(at: indicies)
    }
    
    func fetchRecordedMotion() {
        motionManager(motionManager, didFinishRecording: motionManager.recordedMotion)
    }
    
    // MARK: MotionManagerDelegate
    
    func motionManager(_ motionManager: MotionManager, didFinishRecording deviceMotion: [Motion]) {
        output?.finishedRecording(deviceMotion)
    }
    
}
