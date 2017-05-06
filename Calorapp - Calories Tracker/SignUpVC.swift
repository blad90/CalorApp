//
//  SignUpVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet var fullNameField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var dateOfBirthField: UITextField!
    @IBOutlet var countryField: UITextField!
    
    @IBAction func signUpButton(_ sender: UIButton) {
        signUp()
    }
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func signUp() {
       let user = PFUser()
        user["fullName"] = fullNameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        user["dateOfBirth"] = dateOfBirthField.text
        user["country"] = countryField.text
        
        user.signUpInBackground { (success, error) in
            
            if error != nil {
            
                var displayError = "Try again later."
                
                if let errorMsg = error?.localizedDescription {
                    displayError = errorMsg
                    self.errorLabel.text = displayError
                }
            } else {
                self.cleanUpFields()
                self.performSegue(withIdentifier: "toLoginSegue", sender: self)
                print("Signed Up!")
            }
    }
}
    
    func cleanUpFields() {
        fullNameField.text = ""
        usernameField.text = ""
        passwordField.text = ""
        emailField.text = ""
        dateOfBirthField.text = ""
        countryField.text = ""
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
