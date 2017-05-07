//
//  InfoTableVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class InfoTableVC: UITableViewController {

    var foodNames : [String] = []
    var foodCalories : [String] = []
    var loginVC: LoginVC!
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "loggedOutSegue", sender: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "FoodInfo")
        query.findObjectsInBackground { (objects, error) in
            for object in objects! {
                let foodName = object["foodName"] as! String
                let foodCalorie = object["calories"] as! String
                self.foodNames.append(foodName)
                self.foodCalories.append(foodCalorie)
            }
            self.tableView.reloadData()
            print("\(self.foodNames) contains \(self.foodCalories) calories!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foodNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        
    
        cell.textLabel?.text = foodNames[indexPath.row]
        cell.detailTextLabel?.text = "\(foodCalories[indexPath.row]) calories"
        //cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: index!)!
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
            
        }
        
        let foodItemSelectedName = currentCell.textLabel!.text
        let foodItemSelectedCalorie = currentCell.detailTextLabel!.text
        
        print("Selected: \(String(describing: foodItemSelectedName!)) with \(String(describing: foodItemSelectedCalorie!))")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
