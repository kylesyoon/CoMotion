//
//  ChartModuleInterface.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 8/14/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import Charts

protocol ChartModuleInterface: class {
    
    func startRecordingMotion()
    func stopRecordingMotion()
    
    /// Asks the delegate to give the recorded motion
    ///
    /// - Returns: the recorded motion data
    func fetchLineChartData() -> LineChartData?
    
}
