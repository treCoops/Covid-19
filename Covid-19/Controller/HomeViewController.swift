//
//  HomeViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewInfected: UIView!
    @IBOutlet weak var viewNonInfected: UIView!
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var viewNews: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var txtInfected: UILabel!
    @IBOutlet weak var txtSafe: UILabel!
    @IBOutlet weak var txtTotal: UILabel!
    
    var news : [News] = []
    var mapLocations : [MapLocations] = []
    
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    var validator = Validator()
    
    let locationManager = CLLocationManager()
    var lati: Double = 0
    var long: Double = 0
    
    var safe: Int = 0
    var infected: Int = 0
    
    var mLocation : MapMarker!
    
    let center = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        viewInfected.roundView()
        viewTotal.roundView()
        viewNonInfected.roundView()
        viewParent.roundView()
        viewNews.roundView()
        viewMap.roundView()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        
        
        registerNib()
        addFloatingButton()
        
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
        fireabaseManager.getNewsData()
        indicatorHUD.show()
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        fireabaseManager.getLocationUpdates()
        
        mLocation = MapMarker(coordinate: CLLocationCoordinate2D(latitude: lati, longitude: long))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func registerNib() {
        let nib = UINib(nibName: NewsCell.nibName, bundle: nil)
        newsCollectionView?.register(nib, forCellWithReuseIdentifier: NewsCell.reuseIdentifier)
        if let flowLayout = self.newsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    @IBAction func btnRelocatePressed(_ sender: UIButton) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lati, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: true)
    }
    
    func updateMapData(){
        self.safe = 0
        self.infected = 0
        
        for data in mapLocations{
            
            if data.uid == UserSession.getUserDefault(key: UserRelated.userUID){
                self.mapView.addAnnotation(mLocation)
                continue
            }
            
            let coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
            let pin = MapMarker(coordinate: coordinate)
            if data.temp < 36 {
                pin.title = "SAFE"
                self.safe += 1
            } else {
                pin.title = "RISK"
                self.infected += 1
            }
            
            self.mapView.addAnnotation(pin)
        }
        
        txtSafe.text = String(self.safe)
        txtInfected.text = String(self.infected)
        txtTotal.text = String(self.safe + self.infected)
    }
    
    func addFloatingButton(){
        let button = UIButton(type: .custom) // let preferred over var here
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setImage(#imageLiteral(resourceName: "help"), for: .normal)
        
        button.addTarget(self, action: #selector(onFloatingHelpButtonPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
          let widthContraints =  NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
          
          let heightContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
          
          let xContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottomMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: -20)
          
          let yContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
          
          NSLayoutConstraint.activate([heightContraints,widthContraints,xContraints,yContraints])
    }
    
    @objc
    func onFloatingHelpButtonPressed(){
        
        let alert = PopupDialog.generatePopupAlert(title: "Ask for help", message: "", type: "Help")
        
        let action = UIAlertAction(title: "Call", style: .default, handler: {
            action in
            
            if let phoneCallURL = URL(string: "telprompt://\(0111111117)") {

                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    if #available(iOS 10.0, *) {
                        application.open(phoneCallURL, options: [:], completionHandler: nil)
                    } else {
                         application.openURL(phoneCallURL as URL)

                    }
                }
            }
            
        })
        
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier,
                                                             for: indexPath) as? NewsCell {
            cell.configureCell(news: news[indexPath.row])
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    //re think
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present( PopupDialog.generateAlert(title: "News", msg: news[indexPath.row].news), animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: NewsCell = Bundle.main.loadNibNamed(NewsCell.nibName, owner: self, options: nil)?.first as? NewsCell else {
            return CGSize.zero
        }
        
        cell.configureCell(news: news[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 150)
    }
    
}

extension HomeViewController : FirebaseActions{
    func onNewsDataLoaded(news: [News]) {
        self.news = news
        
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
            self.indicatorHUD.hide()
            self.newsCollectionView.layer.speed = 0.1
            self.newsCollectionView.scrollToItem(at: IndexPath(item: news.count-1, section: 0), at: .right, animated: true)
            
        }
    }
    
    func onLocationDataLoaded(mapLocation: [MapLocations]) {
        self.mapLocations.removeAll()
        self.mapView.removeAnnotations(mapView.annotations)
        self.mapLocations.append(contentsOf: mapLocation)
        self.mapLocations = mapLocation
        self.updateMapData()
    }
    
    func onNewsDataLoadEmpty(error: String){
        print(error)
        self.present(PopupDialog.generateAlert(title: "Alert", msg: error), animated: true)
        indicatorHUD.hide()
    }
    
}

extension HomeViewController : CLLocationManagerDelegate {

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

extension HomeViewController : MKMapViewDelegate{
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

