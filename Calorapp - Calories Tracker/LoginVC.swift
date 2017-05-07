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

    var currentUser = PFUser.current()
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBAction func logInButton(_ sender: UIButton) {
        logIn()
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        
        PFUser.logOut()
        currentUser = PFUser.current()
        
        usernameField.text = ""
        usernameField.isEnabled = true
        usernameField.textColor = UIColor.black
        
        passwordField.text = ""
        passwordField.isEnabled = true
        passwordField.textColor = UIColor.black
        
        logInButton.isHidden = false
        signUpButton.isHidden = false
    }
    
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var logInButton: UIButton!
    @IBAction func signUpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUpSegue", sender: self)
    }
    
    func logIn() {
       PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (success, error) in
        
        if error != nil {
            var displayError = "Try again later."
            
            if let errorMsg = error?.localizedDescription {
                displayError = errorMsg
                
                let alert = UIAlertController(title: "Error", message: "\(displayError) Please try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                })
                self.present(alert, animated: true)
            }
        } else {
            print("Logged In")
            self.performSegue(withIdentifier: "loggedInSegue", sender: nil)

        }
    }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentUser = PFUser.current()
        
        if currentUser != nil {
            print("Logged In")
            performSegue(withIdentifier: "loggedInSegue", sender: nil)
            logInButton.isHidden = true
            signUpButton.isHidden = true
            usernameField.text = currentUser?.username
            usernameField.isEnabled = false
            usernameField.textColor = UIColor.gray
            
            passwordField.text = "******"
            passwordField.isEnabled = false
            passwordField.textColor = UIColor.gray
            
        } else {
            print("Need to log in")
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
