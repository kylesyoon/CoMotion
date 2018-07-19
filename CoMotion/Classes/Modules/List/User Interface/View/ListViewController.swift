//
//  ListViewController.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ListViewInterface {
    
    var eventHandler: ListModuleInterface?
    
    fileprivate var motionData = [Motion]()
    fileprivate var isUpdating: Bool = false {
        didSet {
            if self.isUpdating {
                self.navigationItem.rightBarButtonItem?.title = String.stop
                self.eventHandler?.startMotionUpdates()
            } else {
                self.navigationItem.rightBarButtonItem?.title = String.start
                self.eventHandler?.stoptMotionUpdates()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startStopButton = UIBarButtonItem(title: String.start,
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapStartStopButton(_:)))
        self.navigationItem.rightBarButtonItem = startStopButton
    }
    
    @objc func didTapStartStopButton(_ button: UIBarButtonItem) {
        self.isUpdating = !self.isUpdating
    }
    
    // MARK: ListViewInterface
    
    func add(motion: Motion) {
        // add motion to table view
        print("\(#function): \(motion)")
    }
    
}
