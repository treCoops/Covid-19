//
//  MapViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var mapLocations : [MapLocations] = []
    
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    
    let locationManager = CLLocationManager()
    var lati: Double = 0
    var long: Double = 0
    
    var mLocation : MapMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        fireabaseManager.getLocationUpdates()
        
        mLocation = MapMarker(coordinate: CLLocationCoordinate2D(latitude: lati, longitude: long))
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }
    
    @IBAction func btnRelocatePressed(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lati, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
    func updateMapData(){
        
        for data in mapLocations{
            
            if data.uid == UserSession.getUserDefault(key: UserRelated.userUID){
                self.mapView.addAnnotation(mLocation)
                continue
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
            let pin = MapMarker(coordinate: coordinate)
            if data.temp < 36 {
                pin.title = "SAFE"
                
            } else {
                pin.title = "RISK"
               
            }
            
            self.mapView.addAnnotation(pin)
        }
      
    }


}


extension MapViewController : FirebaseActions{
    func onLocationDataLoaded(mapLocation: [MapLocations]) {
        self.mapLocations.removeAll()
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapLocations.append(contentsOf: mapLocation)
        self.mapLocations = mapLocation
        self.updateMapData()
    }
    
}

extension MapViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            mapView.removeAnnotation(mLocation)
            mLocation = MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            mLocation.title = "I AM"
            self.mapView.addAnnotation(mLocation)
            
            lati = location.coordinate.latitude
            long = location.coordinate.longitude
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.present(PopupDialog.generateAlert(title: "Location error", msg: error.localizedDescription), animated: false)
    }

}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        if annotation.title == "RISK" {
            annotionView.image = #imageLiteral(resourceName: "man_red")
        }
        
        if annotation.title == "SAFE" {
            annotionView.image = #imageLiteral(resourceName: "man_green")
        }
        
        if annotation.title == "I AM" {
            annotionView.image = #imageLiteral(resourceName: "man_me")
        }
        
        annotionView.canShowCallout = true
        return annotionView
    }
}
