//
//  UpdateViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import CoreLocation

class UpdateViewController: UIViewController {

    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var surveyView: UIView!
    @IBOutlet weak var txtTemprature: UILabel!
    @IBOutlet weak var txtC: UILabel!
    @IBOutlet weak var slideTemprature: UISlider!
    @IBOutlet weak var btnUpdate: UIButton!
    
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    var validator = Validator()
    
    let locationManager = CLLocationManager()

    var lati: Double = 0
    var long: Double = 0
    var temp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempView.roundView()
        surveyView.roundView()
        
        if let role : String = UserSession.getUserDefault(key: UserRelated.userType){
            if role == "STAFF"{
                AddFloatingButton()
            }
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
        txtTemprature.text = String(format: "%.1f", slideTemprature.value)
       
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let gestureRecognizion = UITapGestureRecognizer(target: self, action: #selector(self.callSympthonsView))
        self.surveyView.addGestureRecognizer(gestureRecognizion)
        
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        
        if lati == 0 || long == 0{
            if let location = locationManager.location {
                lati = location.coordinate.latitude
                long = location.coordinate.longitude
            }
        }
        
        indicatorHUD.show()
        temp = String(format: "%.2f", slideTemprature.value)
        fireabaseManager.saveTempData(temp: Double(temp)!, lat: lati, long: long, notify: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func tempratureChanged(_ sender: UISlider) {
        txtTemprature.text = String(format: "%.1f", sender.value)
        
        if sender.value < 25{
            
            UIView.animate(withDuration: 0.7, animations: {
                self.slideTemprature.tintColor = #colorLiteral(red: 0, green: 0.7647058824, blue: 0.4, alpha: 1)
                self.txtTemprature.textColor = #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1)
                self.txtC.textColor = #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1)
                self.btnUpdate.backgroundColor = #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1)
            })
            
        }else if sender.value < 30{
            
            UIView.animate(withDuration: 0.7, animations: {
                self.slideTemprature.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                self.txtTemprature.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                self.txtC.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                self.btnUpdate.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            })
            
        }else if sender.value < 40 {
            
            UIView.animate(withDuration: 0.7, animations: {
                self.slideTemprature.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                self.txtTemprature.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                self.txtC.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                self.btnUpdate.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            })
        
        }else{
            
            UIView.animate(withDuration: 0.7, animations: {
                self.slideTemprature.tintColor = #colorLiteral(red: 1, green: 0.110739512, blue: 0.03352418664, alpha: 1)
                self.txtTemprature.textColor = #colorLiteral(red: 1, green: 0.110739512, blue: 0.03352418664, alpha: 1)
                self.txtC.textColor = #colorLiteral(red: 1, green: 0.1098039216, blue: 0.03529411765, alpha: 1)
                self.btnUpdate.backgroundColor = #colorLiteral(red: 1, green: 0.110739512, blue: 0.03352418664, alpha: 1)
            })
            
        }
        
    }
    
    func AddFloatingButton(){
        let button = UIButton(type: .custom) // let preferred over var here
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.setImage(#imageLiteral(resourceName: "add"), for: .normal)

        button.addTarget(self, action: #selector(onFloatingNewsButtonPressed), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
          let widthContraints =  NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
          
          let heightContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
          
          let xContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottomMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: -20)
          
          let yContraints = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
          
          NSLayoutConstraint.activate([heightContraints,widthContraints,xContraints,yContraints])
    }
    
    @objc
    func onFloatingNewsButtonPressed(){
        
        let alert = PopupDialog.generatePopupAlert(title: "Push News", message: "Enter your news", type: "NEWS")
        
        let action = UIAlertAction(title: "Push", style: .default, handler: {
            action in
            if let news = alert.textFields?.first {
                self.indicatorHUD.show()
                self.fireabaseManager.pushNews(news: news.text!)
                
            }
        })
        action.isEnabled = false;
        alert.addAction(action)
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.first, queue: OperationQueue.main, using: {
            notification in
            
            if self.validator.isEmpty(alert.textFields?.first?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid news!"
            } else {
                action.isEnabled = true
                alert.message = "Click push to submit!"
            }
            
        })
        
        self.present(alert, animated: true)
    }
    
    @objc
    func callSympthonsView(){
        self.performSegue(withIdentifier: Seagus.sympthonsSegue, sender: nil)
    }
  
}

extension UpdateViewController : FirebaseActions{
    func operationFailed(error: Error) {
        self.present(PopupDialog.generateAlert(title: "Error", msg: "News not published!"), animated: true)
        indicatorHUD.hide()
    }
    
    func operationSuccess() {
        self.present(PopupDialog.generateAlert(title: "Success", msg: "News published successfully!"), animated: true)
        
        indicatorHUD.hide()
    }
    
    func operationSuccessTemp() {
        self.present(PopupDialog.generateAlert(title: "Success", msg: "Temperature data publish successfully!"), animated: true)
        
        indicatorHUD.hide()
    }
}

extension UpdateViewController : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lati = location.coordinate.latitude
            long = location.coordinate.longitude
            temp = String(format: "%.2f", slideTemprature.value)
            fireabaseManager.saveTempData(temp: Double(temp)!, lat: lati, long: long, notify: false)
            
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.present(PopupDialog.generateAlert(title: "Location error", msg: error.localizedDescription), animated: false)
    }

}

