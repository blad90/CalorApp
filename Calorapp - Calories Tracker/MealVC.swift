//
//  MealVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class MealVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var mealNameField: UITextField!
    @IBOutlet var quantityField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var caloriesField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var foodImageView: UIImageView!
    
    var user = PFUser.current()
    
    @IBAction func logOutButton(_ sender: UIButton) {
        PFUser.logOut()
        performSegue(withIdentifier: "toLoginFromMealVC", sender: nil)
        
    }
    
    @IBAction func importImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        imagePickerController.allowsEditing = false
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            foodImageView.image = image
        } else {
            print("Error while getting the image")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user != nil {
            welcomeLabel.text = "Welcome \(String(describing: user!.username!))"
        }
        
    }

    @IBAction func saveButton(_ sender: UIButton) {
        
        let foodItem = PFObject(className:"FoodList")
        
        if mealNameField.text == "" { //Required field
            let alert = UIAlertController(title: "Required field", message: "You need to provide a food item name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        } else {
            foodItem["foodItem"] = mealNameField.text
        }
        if quantityField.text != "" { //Required field
            foodItem["quantity"] = Int(quantityField.text!)
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to provide a quantity.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        if categoryField.text != "" {
            foodItem["category"] = categoryField.text
        }
        
        if caloriesField.text != "" { //Required field
            foodItem["calories"] = Int(caloriesField.text!)
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to provide the amount of calories.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        //foodItem["image"] = "N/A"
        
        foodItem.saveInBackground()
        
        let alert = UIAlertController(title: "Success", message: "Data saved to your records!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
          self.cleanUpFields()
        })
        self.present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func cleanUpFields() {
        mealNameField.text = ""
        quantityField.text = ""
        categoryField.text = ""
        caloriesField.text = ""
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
