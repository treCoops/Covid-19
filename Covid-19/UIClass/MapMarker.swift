//
//  MapMarker.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import MapKit

class MapMarker: NSObject, MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
    
}
