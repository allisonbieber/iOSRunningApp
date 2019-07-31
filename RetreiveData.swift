//
//  RetreiveData.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 6/26/19.
//

import Foundation
import FirebaseFirestore


@IBAction func retrieveData(_ sender: Any) {
    
    print(datePicker.date)
    
}

func readMiles(date: Int, field: String) {
    let db = Firestore.firestore()
    
    db.collection("Runs").whereField(field, isEqualTo:date).getDocuments { (snapshot, error) in
        if error != nil {
            // catches the error if one occurs
            print(error as Any)
            print("FAILED")
            
        } else {
            // else, grab all the documents with the date == 06172019
            for document in (snapshot?.documents)! {
                if let miles = document.data()["distance"] as? Double {
                    print(miles)
                }
            }
        }
    }
}


