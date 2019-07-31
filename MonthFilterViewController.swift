//
//  MonthFilterViewController.swift
//  
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class MonthFilterViewController: UIViewController {
    
  
     @IBOutlet weak var startDatePicker: UIDatePicker!
     @IBOutlet weak var endDatePicker: UIDatePicker!
     @IBOutlet weak var monthDataTable: UITableView!
     @IBOutlet weak var totalMiles: UITextField!
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userCollection = Auth.auth().currentUser?.email else {return}

        // Do any additional setup after loading the view.
    }
    
    
     @IBAction func monthFilter(_ sender: Any) {
        
         // var runs = [(dist:Double)]()
        
         var total = 0.0
         // var totalTime = 0.0
         let db = Firestore.firestore()
         let after = startDatePicker!.date
         let before = endDatePicker!.date
        
         if before < after {
            print("Date out of range")
             } else {
            
             db.collection("Runs").getDocuments { (snapshot, error) in
             if error != nil {
                print("error")
             } else if snapshot?.count == 0 {
                self.totalMiles.text = String(total)
                 } else {
                         for document in (snapshot?.documents)! {
                         if let year = document.data()["year"] as? String,
                         let month = document.data()["month"] as? String,
                         let day = document.data()["day"] as? String,
                         let miles = document.data()["distance"] as? Double{
                         
                         let dateStr = month + "-" + day + "-" + year
                         
                         let dateFormatter = DateFormatter()
                         dateFormatter.dateFormat = "MM-dd-yyyy"
                         let date = dateFormatter.date(from: dateStr)
                         
                             if date! > after && date! < before {
                             total += miles
                             self.totalMiles.text = String(round(total))
                         
                             } else {
                            self.totalMiles.text = String(total)
                         }
                     }
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
