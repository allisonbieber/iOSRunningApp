//
//  MainPageViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseAuth

/**
 This class is the View Controller class for the 
 **/
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
