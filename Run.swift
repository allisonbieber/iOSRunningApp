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
    var time: Int!
    var year: Int!
    var month: Int!
    var day: Int!
    
    // Constructor for a run object
    init(distance: Double, time: Int, year: Int, month: Int, day: Int ) {
        self.distance = distance
        self.time = time
        self.year = year
        self.month = month
        self.day = day
    }
    
    func returnDate() {
        
    }
}
