//
//  StatsVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/7/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Charts
import Parse

class StatsVC: UIViewController {

    var monthString: String! = ""
    var originalMonths: [String] = []
    var months: [String] = []
    var convertedMonth = ""
    var calorieString: String! = ""
    var calorieUnits: [Double] = []
    var convertedCalorie: Double = 0.0
    var totalCalories: Double = 0.0
    
    @IBOutlet var lineChartView: LineChartView!
    
    func sum(_ calories: [Double]) -> Double {
        var sum: Double = 0.0
        for cal in calories {
            sum += cal
        }
        return sum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className:"FoodList")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                for object in objects! {
                    
                    self.monthString = String(describing: object.createdAt!)
                    self.calorieString = NSString(format: "%@", object["calories"] as! CVarArg) as String
                    
                    if let match = self.monthString.range(of: "(?<=-)[^-]+", options: .regularExpression) {
                        self.convertedMonth = self.monthString.substring(with: match)
                        self.originalMonths.append(self.convertedMonth)
                        
                        self.convertedCalorie = Double(self.calorieString)!
                        
                        self.calorieUnits.append(self.convertedCalorie)
                        self.totalCalories = self.sum(self.calorieUnits)
                        print(self.totalCalories)
                        self.months = self.originalMonths
                    }
                }
                
                  self.setChart(dataPoints: self.months, values: [self.totalCalories])
                  self.lineChartView.xAxis.labelPosition = .bottom
                  self.lineChartView.backgroundColor = UIColor(red: 112/255, green: 181/255, blue: 219/255, alpha: 0.5)
                  self.lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)

            } else {
                print(error?.localizedDescription)
            }
        }

        /*let query = PFQuery(className:"FoodList")
        query.getObjectInBackground(withId: "8D6dIWUmps") {
            (item: PFObject?, error) -> Void in
            self.monthString = String(describing: item!.createdAt!)
            
            if let match = self.monthString.range(of: "(?<=-)[^-]+", options: .regularExpression) {
                let convertedMonth = self.monthString.substring(with: match)
                self.originalMonths.append(convertedMonth)
                
                self.months = self.originalMonths
                self.calorieUnits = [320.0,43.0]
                
                self.setChart(dataPoints: self.months, values: self.calorieUnits)
                self.lineChartView.xAxis.labelPosition = .bottom
                self.lineChartView.backgroundColor = UIColor(red: 112/255, green: 181/255, blue: 219/255, alpha: 0.5)
                
                self.lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
            }
            
        }*/
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Total calories")
        let lineChartData = LineChartData()
        lineChartData.addDataSet(lineChartDataSet)
        lineChartView.data = lineChartData
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
