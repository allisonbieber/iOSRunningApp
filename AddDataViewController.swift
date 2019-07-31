//
//  AddDataViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddDataViewController: UIViewController {
    
    @IBOutlet weak var addDatePicker: UIDatePicker!
    @IBOutlet weak var addMiles: UITextField!
    @IBOutlet weak var addMinutes: UITextField!
    @IBOutlet weak var addSeconds: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userCollection = Auth.auth().currentUser?.email else {return}

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addData(_ sender: Any) {
        
        let db = Firestore.firestore()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateStr = dateFormatter.string(from: addDatePicker.date)
        
        //No document exists with the given name
        dateFormatter.dateFormat = "MM"
        let month = dateFormatter.string(from: self.addDatePicker.date)
        dateFormatter.dateFormat = "dd"
        let day = dateFormatter.string(from: self.addDatePicker.date)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: self.addDatePicker.date)
        
        // Check the input given by the user
        if let min = Int(self.addMinutes.text!), let sec = Int(self.addSeconds.text!), let dist = Double(self.addMiles.text!) {
            
            // Create a document with the fields to add to the database
            db.collection("Runs").document(dateStr
                ).setData(["month" : month,
                           "day" : day,
                           "year" : year,
                           "distance" : dist,
                           "minutes" : min,
                           "seconds" : sec])
            
            //Alert icon to notify that the data has been added
            let alert = UIAlertController(title: "Confirmation", message: "Your data has been added to Firebase", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            //Reset the input fields in the GUI
            self.resetValues()
            
            //If an error occured, indicate with a pop-up
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter valid data", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.resetValues()
        }
        
    }

     /*
     Resets the text box values in the GUI with '0'
 `      */
     func resetValues() {
     addMiles.text = "0"
     addMinutes.text = "0"
     addSeconds.text = "0"
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
