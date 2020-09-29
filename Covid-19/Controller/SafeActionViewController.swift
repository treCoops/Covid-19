//
//  safeActionViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/27/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SafeActionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewContainer: UIView!
    @IBOutlet weak var lblDescription: UILabel!
    
    var counter : Int = 0
    
    var safeActions : [SafeAction] = [
        SafeAction(img: #imageLiteral(resourceName: "wearMask"), description: "Ware a face mask."),
        SafeAction(img: #imageLiteral(resourceName: "disinfectContactElements"), description: "Disinfect content elements."),
        SafeAction(img: #imageLiteral(resourceName: "avoidCrowds"), description: "Avoid crowds."),
        SafeAction(img: #imageLiteral(resourceName: "avoidHandshake"), description: "Avoid handshake."),
        SafeAction(img: #imageLiteral(resourceName: "useSoap"), description: "Use soap."),
        SafeAction(img: #imageLiteral(resourceName: "handWash"), description: "Wash your hand atleast 20 seconds."),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1))
        
        imageView.roundView()
        imageViewContainer.roundView()
        
        let defaultSafeAction : SafeAction = safeActions[counter]

        imageView.image = defaultSafeAction.img
        lblDescription.text = defaultSafeAction.description
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.hideNavigationBar()
       }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        var currentSafeAction : SafeAction
        
        if sender.currentTitle == "Next" {
            counter += 1
            
            if counter == 6 {
               counter = 0
            }
            
            if counter < 6 {
                currentSafeAction = safeActions[counter]
                
                imageView.image = currentSafeAction.img
                lblDescription.text = currentSafeAction.description
            }
            
        }
        
        if sender.currentTitle == "Back" {
            counter -= 1
            
            if counter == -1 {
                counter = 5
            }
            
            if counter >= 0 {
                currentSafeAction = safeActions[counter]
                
                imageView.image = currentSafeAction.img
                lblDescription.text = currentSafeAction.description
            }
            
            
            
        }
    }
}
