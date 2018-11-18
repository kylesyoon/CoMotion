//
//  CoMotionTests.swift
//  CoMotionTests
//
//  Created by Yoon, Kyle on 7/2/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import XCTest
@testable import CoMotion

class ListViewControllerTests: XCTestCase {
    
    private lazy var listViewController: ListViewController = {
        guard let listViewController = UIStoryboard(name: "Main", bundle: Bundle(for: ListViewController.self))
            .instantiateViewController(withIdentifier: String(describing: ListViewController.self)) as? ListViewController else {
                fatalError("There should be a ListViewController in the Main storyboard.")
        }
        
        return listViewController
    }()
    
    private var mockEventHandler = MockListViewControllerEventHandler()
    
    override func setUp() {
        super.setUp()
        
        self.mockEventHandler = MockListViewControllerEventHandler()
        self.listViewController.eventHandler = self.mockEventHandler
        self.listViewController.loadViewIfNeeded()
    }
    
    func testOutletsAreConnected() {
        XCTAssertNotNil(self.listViewController.tableView)
    }
    
    func testTableViewSetup() {
        XCTAssert(self.listViewController.tableView.delegate === self.listViewController)
        XCTAssert(self.listViewController.tableView.dataSource === self.listViewController)
    }
    
    func testNavigationItemSetup() {
        XCTAssertEqual(self.listViewController.navigationItem.title, String.com_list)
        XCTAssertEqual(self.listViewController.navigationItem.rightBarButtonItem?.title, String.com_start)
        XCTAssertEqual(self.listViewController.navigationItem.rightBarButtonItem?.action, #selector(ListViewController.didTapStartStopButton(_:)))
    }
    
    func testTouchUpInsideStartStopButton() {
        XCTAssertEqual(self.mockEventHandler.didStartMotionUpdatesCallCount, 0)
        XCTAssertEqual(self.mockEventHandler.didStopMotionUpdatesCallCount, 0)
        
        guard
            let action = self.listViewController.navigationItem.rightBarButtonItem?.action,
            let target = self.listViewController.navigationItem.rightBarButtonItem?.target else {
                fatalError("There should be a start stop right bar button action in ListViewController.")
        }
        
        UIApplication.shared.sendAction(action,
                                        to: target,
                                        from: nil,
                                        for: nil)

        XCTAssertEqual(self.mockEventHandler.didStartMotionUpdatesCallCount, 1)
        XCTAssertEqual(self.mockEventHandler.didStopMotionUpdatesCallCount, 0)
        XCTAssertEqual(self.listViewController.navigationItem.rightBarButtonItem?.title, String.com_stop)
        
        UIApplication.shared.sendAction(action,
                                        to: target,
                                        from: nil,
                                        for: nil)
        
        XCTAssertEqual(self.mockEventHandler.didStopMotionUpdatesCallCount, 1)
        XCTAssertEqual(self.mockEventHandler.didStopMotionUpdatesCallCount, 1)
        XCTAssertEqual(self.listViewController.navigationItem.rightBarButtonItem?.title, String.com_start)
    }
    
}

class MockListViewControllerEventHandler: ListModuleInterface {
    
    var didStartMotionUpdatesCallCount = 0
    var didStopMotionUpdatesCallCount = 0
    
    func presentChart() {
        
    }
    
    func startMotionUpdates() {
        didStartMotionUpdatesCallCount += 1
    }
    
    func stopMotionUpdates() {
        didStopMotionUpdatesCallCount += 1
    }

}
