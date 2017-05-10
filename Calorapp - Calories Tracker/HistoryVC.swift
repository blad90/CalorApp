//
//  HistoryVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/8/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Charts
import Parse

class HistoryVC: UIViewController {

    
    @IBOutlet var pieChartView: PieChartView!
    var foodItem = ""
    var foodItems: [String] = []
    var calorieString = ""
    var calorie = 0.0
    var calories: [Double] = []
    var foodNames: [String] = []
    var foodCalories: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className:"FoodList")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                
                for object in objects! {
                    
                    self.foodItem = NSString(format: "%@", object["foodItem"] as! CVarArg) as String
                    self.calorieString = NSString(format: "%@", object["calories"] as! CVarArg) as String
                    self.calorie = Double(self.calorieString)!
                    
                    self.foodItems.append(self.foodItem)
                    self.calories.append(self.calorie)
                }
            }
            
            self.foodNames = self.foodItems
            self.foodCalories = self.calories
            
            self.setChart(dataPoints: self.foodNames, values: self.foodCalories)
            self.pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBack)
            self.pieChartView.chartDescription?.text = "";
        }
        
}

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y:values[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Calories")
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
