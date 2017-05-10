//
//  MealVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/6/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse
import SystemConfiguration

class MealVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var mealNameField: UITextField!
    @IBOutlet var quantityField: UITextField!
    @IBOutlet var categoryField: UITextField!
    @IBOutlet var caloriesField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var foodImageView: UIImageView!
    
    let user = PFUser.current()
    let connectivity = Connectivity()
    var infoTableVC = InfoTableVC()
    var selectedFoodItem = ""
    var selectedFoodCalorie = ""
    
    @IBAction func logOutButton(_ sender: UIButton) {
        PFUser.logOut()
        performSegue(withIdentifier: "toLoginFromMealVC", sender: nil)
        
    }
    
    @IBAction func importImage(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
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
        
        if !connectivity.isInternetAvailable() {
            let alert = UIAlertController(title: "Network error", message: "Check your Internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        if user != nil {
            welcomeLabel.text = "Welcome \(String(describing: user!.username!))"
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        print(selectedFoodItem)
        
        if mealNameField.text == "" && caloriesField.text == "" {
            mealNameField.text = selectedFoodItem
            caloriesField.text = selectedFoodCalorie
        }
        
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        //print("---The user is \(user!)")
        let foodItem = PFObject(className: "FoodList")
        
        if mealNameField.text == "" { //Required field
            let alert = UIAlertController(title: "Required field", message: "You need to provide a food item name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        } else {
            foodItem["foodItem"] = mealNameField.text
            foodItem["user"] = user
            
            let date = Date()
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            foodItem["monthCreated"] = String(describing: dateComponents.month!)
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
            if quantityField.text != String(1) {
                foodItem["calories"] = Int(caloriesField.text!)! * Int(quantityField.text!)!
            } else {
                foodItem["calories"] = Int(caloriesField.text!)
            }
            
            
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to provide the amount of calories.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
 
        let imageData = UIImageJPEGRepresentation(foodImageView.image!, 0.005)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        foodItem["image"] = imageFile
        
        if mealNameField.text != "" && caloriesField.text != "" {
            foodItem.saveInBackground()
        }
        
        
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
