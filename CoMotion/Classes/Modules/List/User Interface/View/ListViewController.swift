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
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    fileprivate var sectionData = [ListSectionData]()
    fileprivate var isUpdating: Bool = false {
        didSet {
            if self.isUpdating {
                self.navigationItem.rightBarButtonItem?.title = String.com_stop
                self.activityIndicator.startAnimating()
                self.eventHandler?.startRecordingMotion()
            } else {
                self.navigationItem.rightBarButtonItem?.title = String.com_start
                self.eventHandler?.stopRecordingMotion()
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = String.com_list
        let startStopButton = UIBarButtonItem(title: String.com_start,
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapStartStopButton(_:)))
        navigationItem.rightBarButtonItem = startStopButton
        
        tableView.register(UINib(nibName: String(describing: ListCoordinatesTableViewCell.self), bundle: nil),
                                forCellReuseIdentifier: String(describing: ListCoordinatesTableViewCell.self))
    }
    
    @objc func didTapStartStopButton(_ button: UIBarButtonItem) {
        isUpdating.toggle()
    }
    
    // MARK: ListViewInterface
    
    func presentSectionDataToUserInterface(data: [ListSectionData]) {
        sectionData = data
        tableView.reloadData()
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData[section].timestamp
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let coordinatesCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListCoordinatesTableViewCell.self),
                                                                  for: indexPath) as? ListCoordinatesTableViewCell else {
                                                                    return UITableViewCell()
        }
        
        let itemData = sectionData[indexPath.section].items[indexPath.row]
        
        coordinatesCell.titleLabel.text = itemData.title
        coordinatesCell.xLabel.text = itemData.x
        coordinatesCell.yLabel.text = itemData.y
        coordinatesCell.zLabel.text = itemData.z
        
        return coordinatesCell
    }
    
}
