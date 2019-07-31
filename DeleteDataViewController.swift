//
//  DeleteDataViewController.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 7/2/19.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DeleteDataViewController: UIViewController {
    
    @IBOutlet weak var deleteDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let userCollection = Auth.auth().currentUser?.email else {return}
        

        // Do any additional setup after loading the view.
    }
    
    
     @IBAction func deleteEntry(_ sender: Any) {
        
         let db = Firestore.firestore()
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "MM-dd-yyyy"
         let dateStr = dateFormatter.string(from: deleteDatePicker.date)
        
         let docRef = db.collection("Runs").document(dateStr)
        
         docRef.getDocument { (snapshot, error) in
            if error != nil {
                print("error no document")
             } else {
         
         let alert = UIAlertController(title: "Confirm", message: "Are you sure you want to delete the entry for this date?", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
         action in
         db.collection("Runs").document(dateStr).delete() { err in
             if let err = err {
                print("Error removing document: \(err)")
             } else {
                print("Document successfully removed!")
             }
             }
         
         }))
         alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
         self.present(alert, animated: true)
         
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
