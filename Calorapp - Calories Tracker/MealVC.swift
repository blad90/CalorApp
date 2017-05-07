//
//  MealVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class MealVC: UIViewController {

    @IBOutlet var mealNameField: UITextField!
    @IBOutlet var quantityField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var caloriesField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var welcomeLabel: UILabel!
    var user = PFUser.current()
    
    @IBAction func logOutButton(_ sender: UIButton) {
        PFUser.logOut()
        performSegue(withIdentifier: "toLoginFromMealVC", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if user != nil {
            welcomeLabel.text = "Welcome \(String(describing: user!.username!))"
        }
        
    }

    @IBAction func saveButton(_ sender: UIButton) {
        // Creating the student
        let student = PFObject(className:"Student")
        student["name"] = "Jeff"
        student["course"] = "SWEN-500"
        
        // Creating the course
        let course = PFObject(className:"Course")
        course["course"] = "SWEN-500"
        
        // Add a relation between the Student and Course
        course["studentCourse"] = student
        
        course.saveInBackground()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
