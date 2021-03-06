//
//  ChartViewController.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 8/14/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewInterface {
    
    var eventHandler: ChartModuleInterface?
    
    var chartData: LineChartData?
    
    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = String.com_chart
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chartData = eventHandler?.fetchLineChartData()
        lineChartView.data = chartData
    }
    
    
}
