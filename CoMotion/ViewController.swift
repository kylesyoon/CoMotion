//
//  ViewController.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/2/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit
import WatchConnectivity


class ViewController: UIViewController {
    let connectivityManager = ConnectivityManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WCSession.default.delegate = connectivityManager
        WCSession.default.activate()
    }

}
