//
//  ReadDataViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ReadDataViewController: UIViewController {
    
     //Outlets for the retrieve data screen
     @IBOutlet weak var retrieveDatePicker: UIDatePicker!
     @IBOutlet weak var dateText: UITextField!
     @IBOutlet weak var retreiveDateButton: UIButton!
     @IBOutlet weak var milesText: UITextField!
     @IBOutlet weak var timeText: UITextField!
     @IBOutlet weak var paceText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userCollection = Auth.auth().currentUser?.email else {return}

        // Do any additional setup after loading the view.
    }
    
    
     @IBAction func retreieveDataPressed(_ sender: Any) {
     
         //Formats the date from the UIDatePicker
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM-dd-yyyy"
         let dateStr = dateFormatter.string(from: retrieveDatePicker.date)
        
         dateFormatter.dateFormat = "MM"
         let month = dateFormatter.string(from: retrieveDatePicker.date)
         dateFormatter.dateFormat = "dd"
         let day = dateFormatter.string(from: retrieveDatePicker.date)
         dateFormatter.dateFormat = "yyyy"
         let year = dateFormatter.string(from: retrieveDatePicker.date)
        
         //Set the date field to the full date string
         dateText.text=dateStr
        
         //Initialize the connection to the database
         let db = Firestore.firestore()
        
         // Find the document where the fields match the user input (date)
         db.collection("Runs").whereField("day", isEqualTo:day).whereField("month", isEqualTo: month).whereField("year", isEqualTo: year).getDocuments { (snapshot, error) in
             if error != nil {
                 // catches the error if one occurs
                 print(error as Any)
                 print("FAILED")
         
             } else if snapshot?.count == 0 {
         
                 //Create a pop-up alert if no documents are found
                 let alert = UIAlertController(title: "Error", message: "No data found", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                 self.present(alert, animated: true)
                
                 // Indicate that no values were found
                 self.timeText.text = "none"
                 self.milesText.text = "none"
                 self.paceText.text = "none"
         
             } else {
         
             // else, grab all the documents with the given date String
             for document in (snapshot?.documents)! {
                

                 if var minutes = document.data()["minutes"] as? Int,
                    let miles = document.data()["distance"] as? Double,
                    let seconds = document.data()["seconds"] as? Int
                    {
                    
                    let paceTime = (Double(minutes) + Double(seconds / 60))
                        
                    let run = Run(distance: miles, time: paceTime, year: year, month: month, day: day)
                    
                    if minutes > 60 {
                        let hours = minutes / 60
                        minutes = minutes % 60
                        self.timeText.text = String(hours) + ":" + String(minutes) + ":" + String(seconds)
                     } else {
                        self.timeText.text = String(minutes) + " : " + String(seconds)
                     }
                        self.milesText.text = String(miles)
                        self.paceText.text = String(round((paceTime / miles) * 100) / 100)
                     } else {
                        print("failed to retrieve data")
                 }
                }
             }
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
