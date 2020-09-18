//
//  Survey.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation

struct Survey {
    var nic: String
    var profilePicUirl: String
    var role: String
    var name: String
    var score: Int
    var date: String
    var dateValue: Date?
    
    init(nic: String, profilePicUirl: String, role: String, name: String, score: Int, date: String, dateValue: Date?) {
        self.nic = nic
        self.profilePicUirl = profilePicUirl
        self.role = role
        self.name = name
        self.score = score
        self.date = date
        self.dateValue = dateValue
    }
}
