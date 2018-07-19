//
//  ListPresenter.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/18/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation

class ListPresenter: ListInteractorOutput, ListModuleInterface {
    
    var interactor: ListInteractorInput?
    var userInterface: ListViewInterface?
    
    // MARK: ListInteractorOutput
    
    func update(_ motion: Motion) {
        userInterface?.add(motion: motion)
    }
    
    // MARK: ListModuleInterface
    
    func startMotionUpdates() {
        interactor?.startMotionUpdates()
    }
    
    func stoptMotionUpdates() {
        interactor?.stopMotionUpdates()
    }
    
}
