//
//  PopupDialog.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class PopupDialog {
    static func generatePopupAlert(title: String, message: String, type: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if type == "NEWS"{
            
            alert.addTextField(configurationHandler: {
                txtNewsFiels in
                txtNewsFiels.placeholder = "Enter your news!"
            })
            
        } else if type == "NAME"{
            
            alert.addTextField(configurationHandler: {
                           txtNameFiels in
                           txtNameFiels.placeholder = "Enter your name!"
                       })
        
        } else if type == "EMAIL" {
            
            alert.addTextField(configurationHandler: {
                txtEmailFiels in
                txtEmailFiels.placeholder = "Enter your email!"
            })
            
        } else if type == "PASSWORD" {
            
            alert.addTextField(configurationHandler: {
                txtPasswordFiels in
                txtPasswordFiels.isSecureTextEntry = true
                txtPasswordFiels.placeholder = "Enter your password!"
            })
            
            alert.addTextField(configurationHandler: {
                txtConfirmPasswordFiels in
                txtConfirmPasswordFiels.isSecureTextEntry = true
                txtConfirmPasswordFiels.placeholder = "Enter the confirm password!"
            })
            
        }
        
        return alert
    }
    
    static func generateAlert(title: String, msg: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    static func generateAlertWithoutButton(title: String, msg: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        return alert
    }
    
    static func generateAlertOnlyOKButton(title: String, msg: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
}
