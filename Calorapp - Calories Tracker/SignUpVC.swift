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
    var currentUser = PFUser.current()
    
    @IBAction func signUpButton(_ sender: UIButton) {
        signUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func signUp() {
            let user = PFUser()
            if fullNameField.text == "" { //Required field
            let alert = UIAlertController(title: "Required field", message: "You need to provide your name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
            }else{
             user["fullName"] = fullNameField.text
            }
        
        if usernameField.text != "" { //Required field
            user.username = usernameField.text
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to provide a username.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        if passwordField.text != "" { //Required field
            user.password = passwordField.text
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to provide a password.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        if emailField.text != "" { //Required field
            user.email = emailField.text
        } else {
            let alert = UIAlertController(title: "Required field", message: "You need to put your email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            self.present(alert, animated: true)
        }
        
        if dateOfBirthField.text == "" {
            user["dateOfBirth"] = "N/A"
        } else{
            user["dateOfBirth"] = dateOfBirthField.text
        }
        
        if countryField.text == "" {
            user["country"] = "N/A"
        } else{
            user["country"] = countryField.text
        }
        
        user.signUpInBackground { (success, error) in
                
                if error != nil {
                    
                    var displayError = "Try again later."
                    
                    if let errorMsg = error?.localizedDescription {
                        displayError = errorMsg
                        
                        let alert = UIAlertController(title: "Error", message: "\(displayError)", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Log In", style: .default) { action in
                            self.performSegue(withIdentifier: "toLoginSegue", sender: nil)
                        })
                        
                        alert.addAction(UIAlertAction(title: "Try again", style: .default) { action in
                            
                        })
                        
                        
                        self.present(alert, animated: true)
                        
                    }
                } else {
                    self.cleanUpFields()
                    self.performSegue(withIdentifier: "toLoginSegue", sender: nil)
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
