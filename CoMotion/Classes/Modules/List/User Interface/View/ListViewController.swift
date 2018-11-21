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
    @IBOutlet var toolBar: UIToolbar!
    
    fileprivate var sectionData = [ListSectionData]()
    fileprivate var isUpdating: Bool = false {
        didSet {
            if self.isUpdating {
                startStopButton?.title = String.com_stop
                activityIndicator.startAnimating()
                eventHandler?.startRecordingMotion()
            } else {
                eventHandler?.stopRecordingMotion()
                activityIndicator.stopAnimating()
                startStopButton?.title = String.com_start
                if let selectedCount = tableView.indexPathsForSelectedRows?.count, selectedCount > 0 {
                    deleteButton?.isEnabled = true
                }
                tableView.reloadData()
            }
        }
    }
    fileprivate var startStopButton: UIBarButtonItem?
    fileprivate var deleteButton: UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = String.com_list

        tableView.register(UINib(nibName: String(describing: ListCoordinatesTableViewCell.self), bundle: nil),
                                forCellReuseIdentifier: String(describing: ListCoordinatesTableViewCell.self))
        
        let startStopButton = UIBarButtonItem(title: String.com_start,
                                              style: .plain,
                                              target: self,
                                              action: #selector(didTapStartStopButton(_:)))
        self.startStopButton = startStopButton
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        
        let deleteButton = UIBarButtonItem(title: String.com_delete,
                                           style: .plain,
                                           target: self,
                                           action: #selector(didTapDeleteButton(_:)))
        deleteButton.isEnabled = false // disable when none are selected
        self.deleteButton = deleteButton
        
        toolBar.setItems([startStopButton, flexSpace, deleteButton], animated: true)
    }
    
    // MARK: Private
    
    @objc func didTapStartStopButton(_ button: UIBarButtonItem) {
        isUpdating.toggle()
    }
    
    @objc func didTapDeleteButton(_ button: UIBarButtonItem) {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { return }
        // dont remove redundant sections because it will delete the next one in line
        let selectedSections = Array(Set(selectedIndexPaths.map { $0.section }))
        eventHandler?.deleteMotion(at: selectedSections)
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

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // user can only delete entire data points (rather than one property of motion)
        // so select entire section
        for row in 0..<sectionData[indexPath.section].items.count {
            tableView.selectRow(at: IndexPath(row: row, section: indexPath.section),
                                animated: false,
                                scrollPosition: .none)
        }
        
        guard
            let deleteButton = deleteButton else {
            assertionFailure("Couldn't find a delete button!")
            return
        }
        
        if !deleteButton.isEnabled {
            deleteButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // user can only delete entire data points (rather than one property of motion)
        // so deselect entire section
        for row in 0..<sectionData[indexPath.section].items.count {
            tableView.deselectRow(at: IndexPath(row: row, section: indexPath.section),
                                  animated: false)
        }
        
        if tableView.indexPathsForSelectedRows?.count == 0 {
            deleteButton?.isEnabled = false
        }
    }
    
}
