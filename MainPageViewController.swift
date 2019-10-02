//
//  MainPageViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseAuth

class MainPageViewController: UIViewController {

    @IBOutlet weak var accountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = Auth.auth().currentUser?.email else {return}
        accountLabel.text = email

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "signedOutSegue", sender: self)
           // self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            print("Error at signing out", error.localizedDescription)
        }
    }
    

}
