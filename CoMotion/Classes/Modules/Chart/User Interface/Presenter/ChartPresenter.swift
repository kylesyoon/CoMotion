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
    
    func attribute(motion: Motion, key: String) -> Double {
        switch key {
        case "Attitude Roll":
            return motion.attitude.roll
        case "Attitude Pitch":
            return motion.attitude.pitch
        case "Attitude Yaw":
            return motion.attitude.yaw
        case "Rotation Rate X":
            return motion.rotationRate.x
        case "Rotation Rate Y":
            return motion.rotationRate.y
        case "Rotation Rate Z":
            return motion.rotationRate.z
        case "Gravity X":
            return motion.gravity.x
        case "Gravity Y":
            return motion.gravity.y
        case "Gravity Z":
            return motion.gravity.z
        case "User Acc. X":
            return motion.userAcceleration.z
        case "User Acc. Y":
            return motion.userAcceleration.y
        case "User Acc. Z":
            return motion.userAcceleration.z
        case "Heading":
            return motion.heading
        default:
            return 0.0
        }
    }
    
    let motionPropertyKeys = ["Attitude Roll", "Attitude Pitch", "Attitude Yaw",
                              "Rotation Rate X", "Rotation Rate Y", "Rotation Rate Z",
                              "Gravity X", "Gravity Y", "Gravity Z",
                              "User Acc. X", "User Acc. Y", "User Acc. Z",
                              "Heading"]

    func fetchLineChartData() -> LineChartData? {
        // get data from interactor
        guard
            let recordedMotion = interactor?.fetchRecordedMotion(),
            recordedMotion.count > 0 else {
                // no recorded data
                return nil
        }
        
        return convertRecordedMotionToChartData(recordedMotion)
    }
    
    // MARK: ChartInteractorOutput
    
    func finishedRecording(_ motionData: [Motion]) {
        // update interface
    }
    
    // MARK: Private
    
    private func convertRecordedMotionToChartData(_ recordedMotion: [Motion]) -> LineChartData {
        var dataKeyEntries = [Motion.PropertyKeys: [ChartDataEntry]]()
        
        for motion in recordedMotion {
            Motion.PropertyKeys.allCases.forEach { propertyCase in
                let property = motion.property(key: propertyCase)
                let chartEntry = ChartDataEntry(x: motion.timestamp, y: property)
                if var entries = dataKeyEntries[propertyCase] {
                    entries.append(chartEntry)
                    dataKeyEntries[propertyCase] = entries
                } else {
                    dataKeyEntries[propertyCase] = [chartEntry]
                }
            }
        }
        
        var dataSets = [LineChartDataSet]()
        
        Motion.PropertyKeys.allCases.enumerated().forEach { index, propertyCase in
            let set = LineChartDataSet(values: dataKeyEntries[propertyCase], label: propertyCase.rawValue)
            set.drawCircleHoleEnabled = false
            set.circleRadius = 2.0
            let indexBasedColor = UIColor(red: CGFloat(Double(index + 1) / Double(Motion.PropertyKeys.allCases.count)),
                                          green: 0.0,
                                          blue: CGFloat(Double(Motion.PropertyKeys.allCases.count - index + 1) / Double(Motion.PropertyKeys.allCases.count)),
                                          alpha: 1.0)
            set.setColor(indexBasedColor)
            set.setCircleColor(indexBasedColor)
            dataSets.append(set)
        }
        
        return LineChartData(dataSets: dataSets)
    }
    
}
