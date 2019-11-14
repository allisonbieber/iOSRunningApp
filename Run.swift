//
//  Run.swift
//  FirebaseProject
//
//  Created by Allison Bieber on 6/18/19.
//

import Foundation

/**
 This class represents a single run object.
 **/
class Run {
    
    var distance: Double!
    var time: Double!
    var year: String!
    var month: String!
    var day: String!
    
    // Constructor for a run object
    init(distance: Double, time: Double, year: String, month: String, day: String ) {
        self.distance = distance
        self.time = time //time in seconds
        self.year = year
        self.month = month
        self.day = day
    }
    
    func returnDate() -> String {
        let date = String(self.day) + String(self.month) + String(self.year)
        return date
    }
    
    func getPace() -> Double{

        let hours = Int(self.time / 3600)
        let minutes = hours % 60
        let seconds = minutes % 60
        return 0.0
        
    }
}
