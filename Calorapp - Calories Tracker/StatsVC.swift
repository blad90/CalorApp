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

    var monthString = ""
    var originalMonths: [String] = []
    var months: [String] = []
    var convertedMonth = ""
    var calorieString: String! = ""
    var calorieUnits: [Double] = []
    var monthlyCalorie: [Double] = []
    var convertedCalorie: Double = 0.0
    var totalCalories: Double = 0.0
    
    let monthNames = Months()
    var monthsDict = [String:Double]()

    @IBOutlet var caloriesPerMonthLabel: UILabel!
    @IBOutlet var caloriesLifetimeLabel: UILabel!
    @IBOutlet var lineChartView: LineChartView!
    
    struct Months {
        
        static let JANUARY = "1"
        static let FEBRUARY = "2"
        static let MARCH = "3"
        static let APRIL = "4"
        static let MAY = "5"
        static let JUNE = "6"
        static let JULY = "7"
        static let AUGUST = "8"
        static let SEPTEMBER = "9"
        static let OCTOBER = "10"
        static let NOVEMBER = "11"
        static let DECEMBER = "12"
    }
    
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
                    
                    //self.monthString = String(describing: object.createdAt!)
                    self.monthString = NSString(format: "%@", object["monthCreated"] as! CVarArg) as String
                    self.calorieString = NSString(format: "%@", object["calories"] as! CVarArg) as String

                    self.originalMonths.append(self.monthString)
                    self.convertedCalorie = Double(self.calorieString)!
                    
                    self.monthsDict = [self.monthString:self.convertedCalorie]
                    
                    self.calorieUnits.append(self.convertedCalorie)
                    
                    self.totalCalories = self.sum(self.calorieUnits)
                    self.months = self.originalMonths
                }
                
                //print(self.calorieUnits)
                self.caloriesLifetimeLabel.text = String(self.totalCalories)
                self.caloriesPerMonthLabel.text = String(self.totalCalories*5)
                
                self.setChart(dataPoints: self.months, values: self.calorieUnits)
                self.lineChartView.xAxis.labelPosition = .bottom
                self.lineChartView.backgroundColor = UIColor(red: 112/255, green: 181/255, blue: 219/255, alpha: 0.5)
                self.lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
                self.lineChartView.chartDescription?.text = ""
                
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Calories")
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
