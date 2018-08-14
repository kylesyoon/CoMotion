//
//  ListInteractorTests.swift
//  CoMotionTests
//
//  Created by Yoon, Kyle on 8/14/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import XCTest
@testable import CoMotion

class ListInteractorTests: XCTestCase {
    
    var mockMotionManager = MockMotionManager()
    var mockListInteractorOutput = MockListInteractorOutput()
    var interactor = ListInteractor(motionManager: MockMotionManager())
    
    override func setUp() {
        super.setUp()
        
        mockMotionManager = MockMotionManager()
        mockListInteractorOutput = MockListInteractorOutput()
        
        interactor = ListInteractor(motionManager: mockMotionManager)
        interactor.output = mockListInteractorOutput
    }
    
    func testStartMotionUpdates() {
        interactor.startMotionUpdates()
        XCTAssertEqual(mockMotionManager.didStartCallCount, 1)
    }
    
    func testStopMotionUpdates() {
        interactor.stopMotionUpdates()
        XCTAssertEqual(mockMotionManager.didStopCallCount, 1)
    }
    
    func testUpdate() {
        let motion = Motion(attitude: Attitude(roll: 0.1, pitch: 0.2, yaw: 0.3),
                            rotationRate: Coordinates3D(x: 0.4, y: 0.5, z: 0.6),
                            gravity: Coordinates3D(x: 0.7, y: 0.8, z: 0.9),
                            userAcceleration: Coordinates3D(x: 1.0, y: 1.1, z: 1.2),
                            heading: 1.3,
                            timestamp: 1.4)
        interactor.output?.update(motion)
        
        XCTAssertEqual(mockListInteractorOutput.didUpdateCallCount, 1)
        
        guard let firstMotionData = self.mockListInteractorOutput.motions.first else {
            fatalError("The mock view interface should have one section data object.")
        }
        
        XCTAssertEqual(firstMotionData.attitude.roll, 0.1)
        XCTAssertEqual(firstMotionData.attitude.pitch, 0.2)
        XCTAssertEqual(firstMotionData.attitude.yaw, 0.3)
        
        XCTAssertEqual(firstMotionData.rotationRate.x, 0.4)
        XCTAssertEqual(firstMotionData.rotationRate.y, 0.5)
        XCTAssertEqual(firstMotionData.rotationRate.z, 0.6)
        
        XCTAssertEqual(firstMotionData.gravity.x, 0.7)
        XCTAssertEqual(firstMotionData.gravity.y, 0.8)
        XCTAssertEqual(firstMotionData.gravity.z, 0.9)
        
        XCTAssertEqual(firstMotionData.userAcceleration.x, 1.0)
        XCTAssertEqual(firstMotionData.userAcceleration.y, 1.1)
        XCTAssertEqual(firstMotionData.userAcceleration.z, 1.2)
        
        XCTAssertEqual(firstMotionData.heading, 1.3)
        XCTAssertEqual(firstMotionData.timestamp, 1.4)
    }
    
}

class MockMotionManager: MotionManager {
    
    var didStartCallCount = 0
    var didStopCallCount = 0
    
    override func start() {
        didStartCallCount += 1
    }
    
    override func stop() {
        didStopCallCount += 1
    }
    
}

class MockListInteractorOutput: ListInteractorOutput {
    
    var didUpdateCallCount = 0
    var motions = [Motion]()
    
    func update(_ motion: Motion) {
        didUpdateCallCount += 1
        motions.append(motion)
    }
    
}

