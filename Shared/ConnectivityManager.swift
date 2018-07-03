//
//  ConnectivityManager.swift
//
//  Created by Yoon, Kyle on 7/3/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import WatchConnectivity

class ConnectivityManager: NSObject, WCSessionDelegate {
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?) {
        #if os(watchOS)
        print("watchOS")
        #else
        print("iOS")
        #endif
        
        print("\(#function) session: \(session), activationState: \(activationState), error: \(String(describing: error))")
    }
    
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function) session: \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("\(#function) session: \(session)")
    }
    #endif
    
}

