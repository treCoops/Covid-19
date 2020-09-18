//
//  MapLocation.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation

struct MapLocations {
    
    var temp : Double
    var lat: Double
    var long: Double
    var uid: String
    var updatedDate: String
    
    init(temp: Double, lat: Double, long: Double, uid: String, updatedDate: String) {
        self.temp = temp
        self.lat = lat
        self.long = long
        self.uid = uid
        self.updatedDate = updatedDate
    }
}
