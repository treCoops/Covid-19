//
//  checkBiometricsViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/26/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import LocalAuthentication

class CheckBiometricsViewController: UIViewController {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnUse: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if LAContext().biometricType == .faceID{
            lblDescription.text = "Unlock with Face ID to open Covid 19"
            btnUse.setTitle("Use Face ID", for: .normal)
        } else if LAContext().biometricType == .touchID{
            lblDescription.text = "Unlock with Touch ID to open Covid 19"
            btnUse.setTitle("Use Touch ID", for: .normal)
        }

    }

    @IBAction func useButtonPressed(_ sender: UIButton) {
    
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Place your finger on home button!"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.performSegue(withIdentifier: Seagus.biometricsToHome, sender: nil)
                    } else {
                        self.present(PopupDialog.generateAlertOnlyOKButton(title: "Authentication failed", msg: "You could not be verified!. Please try again."), animated: true)
                    }
                }
            }
        } else {
            print("Biometrics Error")
        }
    }
    
    
}

