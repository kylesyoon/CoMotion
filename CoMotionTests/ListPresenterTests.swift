//
//  ListPresenterTests.swift
//  CoMotionTests
//
//  Created by Yoon, Kyle on 8/13/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import XCTest
@testable import CoMotion

class ListPresenterTests: XCTestCase {
    
    var presenter = ListPresenter()
    var mockInteractor = MockListInteractor()
    var mockViewInterface = MockListViewInterface()
    
    override func setUp() {
        super.setUp()
        
        self.presenter = ListPresenter()
        
        self.mockInteractor = MockListInteractor()
        self.presenter.interactor = self.mockInteractor
        
        self.mockViewInterface = MockListViewInterface()
        self.presenter.userInterface = self.mockViewInterface
    }
    
    func testUpdateMotion() {
        let motion = Motion(attitude: Attitude(roll: 0.1, pitch: 0.2, yaw: 0.3),
                            rotationRate: Coordinates3D(x: 0.4, y: 0.5, z: 0.6),
                            gravity: Coordinates3D(x: 0.7, y: 0.8, z: 0.9),
                            userAcceleration: Coordinates3D(x: 1.0, y: 1.1, z: 1.2),
                            heading: 1.3,
                            timestamp: 1.4)
        
        self.presenter.update(motion)
        
        XCTAssertEqual(self.mockViewInterface.sectionData.count, 1)
        
        guard let firstSectionData = self.mockViewInterface.sectionData.first else {
            fatalError("The mock view interface should have one section data object.")
        }
        
        XCTAssertEqual(firstSectionData.items.count, 4)
        
        let attitude = firstSectionData.items[0]
        XCTAssertEqual(attitude.title, String.com_attitude)
        XCTAssertEqual(attitude.x, "0.1")
        XCTAssertEqual(attitude.y, "0.2")
        XCTAssertEqual(attitude.z, "0.3")
        
        let rotation = firstSectionData.items[1]
        XCTAssertEqual(rotation.title, String.com_rotationRate)
        XCTAssertEqual(rotation.x, "0.4")
        XCTAssertEqual(rotation.y, "0.5")
        XCTAssertEqual(rotation.z, "0.6")
        
        let gravity = firstSectionData.items[2]
        XCTAssertEqual(gravity.title, String.com_gravity)
        XCTAssertEqual(gravity.x, "0.7")
        XCTAssertEqual(gravity.y, "0.8")
        XCTAssertEqual(gravity.z, "0.9")
        
        let accel = firstSectionData.items[3]
        XCTAssertEqual(accel.title, String.com_userAcceleration)
        XCTAssertEqual(accel.x, "1.0")
        XCTAssertEqual(accel.y, "1.1")
        XCTAssertEqual(accel.z, "1.2")
        
        XCTAssertEqual(firstSectionData.timestamp, "1.4")
    }
    
    func testStartMotionUpdates() {
        self.presenter.startMotionUpdates()
        XCTAssertEqual(self.mockInteractor.didStartMotionUpdatesCallCount, 1)
    }
    
    func testStopMotionUpdates() {
        self.presenter.stopMotionUpdates()
        XCTAssertEqual(self.mockInteractor.didStopMotionUpdatesCallCount, 1)
    }
    
}

class MockListInteractor: ListInteractorInput {
    
    var didStartMotionUpdatesCallCount = 0
    var didStopMotionUpdatesCallCount = 0
    
    func startMotionUpdates() {
        didStartMotionUpdatesCallCount += 1
    }
    
    func stopMotionUpdates() {
        didStopMotionUpdatesCallCount += 1
    }
    
}

class MockListViewInterface: ListViewInterface {
    
    var sectionData = [ListSectionData]()
    
    func addSectionDataToUserInterface(data: ListSectionData) {
        self.sectionData.append(data)
    }

}
