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
    
    var news : [String] = []
    
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    var validator = Validator()
    
    let locationManager = CLLocationManager()
    var lati: Double = 0
    var long: Double = 0
    
    
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
        locationManager.startUpdatingLocation()
        
        registerNib()
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
        fireabaseManager.getNewsData()
        indicatorHUD.show()
        mapView.showsUserLocation = true
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
    
    
}

extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier,
                                                             for: indexPath) as? NewsCell {
            cell.configureCell(name: news[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.present( PopupDialog.generateAlert(title: "News", msg: news[indexPath.row]), animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: NewsCell = Bundle.main.loadNibNamed(NewsCell.nibName, owner: self, options: nil)?.first as? NewsCell else {
            return CGSize.zero
        }
        
        cell.configureCell(name: news[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 150)
    }
    
}

extension HomeViewController : FirebaseActions{
    func onNewsDataLoaded(news: [String]) {
        self.news = news
        
        DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
            self.indicatorHUD.hide()
            self.newsCollectionView.layer.speed = 0.1
            self.newsCollectionView.scrollToItem(at: IndexPath(item: news.count-1, section: 0), at: .right, animated: true)
            
        }
    }
    
}

extension HomeViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
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
