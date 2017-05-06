//
//  LoginVC.swift
//  Calorapp - Calories Tracker
//
//  Created by Bladimir Baez on 5/5/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    @IBAction func logInButton(_ sender: UIButton) {
        logIn()
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpSegue", sender: self)
    }
    
    func logIn() {
       PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (success, error) in
        
        if error != nil {
            var displayError = "Try again later."
            
            if let errorMsg = error?.localizedDescription {
                displayError = errorMsg
                self.errorLabel.text = displayError
            }
        } else {
            print("Logged In")
        }
        
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
