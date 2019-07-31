//
//  ViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 6/17/19.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    
    //User Authentication for login page
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
    }
    
    func createUser(email: String, password: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                // User has been created
                print("Account Created")
                //Sign-in user
                self.signIn(email: email, password: password)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                // Signed in
                self.performSegue(withIdentifier: "signedIn", sender: self)
            } else if error?._code == AuthErrorCode.userNotFound.rawValue {
                //Check if the error thrown is User Not Found
                let alert = UIAlertController(title: "Username/Password Not Found", message: "Would you like to create this account?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                    action in
                    self.createUser(email: email, password: password)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            } else if error?._code == AuthErrorCode.wrongPassword.rawValue {
                let alert = UIAlertController(title: "Error", message: "Incorrect Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(alert, animated: true)
                
            }
                else {
                print(error)
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {

        self.signIn(email: emailInput.text!, password: pwInput.text!)
    }
    

    @IBAction func SignUpBtn(_ sender: Any) {
        
        self.createUser(email: emailInput.text!, password: pwInput.text!)
        
    }

}



