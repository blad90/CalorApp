//
//  HistoryVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/8/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Charts

class HistoryVC: UIViewController {

    @IBOutlet var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let months = ["Pizza", "Sandwich", "Soup", "Salad", "Apple", "Orange Juice"]
        let unitsSold = [987.0, 455.0, 221.0, 192.0, 203.0, 1903.0]
        
        setChart(dataPoints: months, values: unitsSold)
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBack)
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Total Calories")
        let pieChartData = PieChartData()
        pieChartData.addDataSet(pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255),  alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
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
