//
//  UpdateViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var surveyView: UIView!
    @IBOutlet weak var txtTemprature: UILabel!
    @IBOutlet weak var txtC: UILabel!
    @IBOutlet weak var slideTemprature: UISlider!
    @IBOutlet weak var btnUpdate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempView.roundView()
        surveyView.roundView()
        
        AddFloatingButton()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let gestureRecognizion = UITapGestureRecognizer(target: self, action: #selector(self.callSympthonsView))
        self.surveyView.addGestureRecognizer(gestureRecognizion)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func tempratureChanged(_ sender: UISlider) {
        txtTemprature.text = String(format: "%.1f", sender.value)
        
        if sender.value < 25{
            
            UIView.animate(withDuration: 0.7, animations: {
                self.slideTemprature.tintColor = #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1)
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
                self.txtC.textColor = #colorLiteral(red: 1, green: 0.110739512, blue: 0.03352418664, alpha: 1)
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
        self.present(PopupDialog.generatePopupAlert(), animated: true)
    }
    
    @objc
    func callSympthonsView(){
        self.performSegue(withIdentifier: Seagus.sympthonsSegue, sender: nil)
    }
  
}
