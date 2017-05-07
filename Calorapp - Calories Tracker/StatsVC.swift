//
//  StatsVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/7/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Charts

class StatsVC: UIViewController {

    //@IBOutlet var barChartView: BarChartView!
    @IBOutlet var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lineChartView.noDataText = "No data available"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
