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
    @IBOutlet weak var btnUpdate: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempView.roundView()
        surveyView.roundView()
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
  
}