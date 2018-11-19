//
//  ChartPresenter.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 8/14/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import Foundation
import Charts

class ChartPresenter: ChartInteractorOutput, ChartModuleInterface {
    
    var interactor: ChartInteractorInput?
    var userInterface: ChartViewInterface?
    
    // MARK: ChartModuleInterface
    
    func startRecordingMotion() {
        interactor?.startRecordingMotion()
    }
    
    func stopRecordingMotion() {
        interactor?.stopRecordingMotion()
    }
    
    func fetchLineChartData() -> LineChartData? {
        // get data from interactor
        guard
            let recordedMotion = interactor?.fetchRecordedMotion(),
            recordedMotion.count > 0 else {
                return nil
        }
        // convert to line chart data
        let values = recordedMotion.map { motion -> ChartDataEntry in
            return ChartDataEntry(x: motion.timestamp, y: motion.userAcceleration.x)
        }
        
        let userAccXSet = LineChartDataSet(values: values, label: String.com_userAcceleration + " X")
        
        let lineChartData = LineChartData(dataSet: userAccXSet)
        
        return lineChartData
    }
    
    // MARK: ChartInteractorOutput
    
    func finishedRecording(_ motionData: [Motion]) {
        // update interface
    }
    
}
