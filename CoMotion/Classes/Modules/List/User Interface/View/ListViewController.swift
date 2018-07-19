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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startStopButton = UIBarButtonItem(title: NSLocalizedString("Start", comment: "Start"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapStartStopButton(_:)))
        self.navigationItem.rightBarButtonItem = startStopButton
    }
    
    @objc func didTapStartStopButton(_ button: UIBarButtonItem) {
        
    }
    
    // MARK: ListViewInterface
    
    func add(motion: Motion) {
        // add motion to table view
    }
    
}
