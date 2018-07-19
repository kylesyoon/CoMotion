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
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var motionData = [MotionListDisplayData]()
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
    
    func addMotionToUserInterface(motion: MotionListDisplayData) {
        self.motionData.append(motion)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.motionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rightDetailCell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell", for: indexPath)
        let motionDisplay = self.motionData[indexPath.row]
        
        rightDetailCell.textLabel?.text = motionDisplay.title
        rightDetailCell.detailTextLabel?.text = motionDisplay.timestamp
        
        return rightDetailCell
    }
    
}
