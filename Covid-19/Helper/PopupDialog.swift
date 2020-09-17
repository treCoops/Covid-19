//
//  PopupDialog.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class PopupDialog {
    static func generatePopupAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Push News", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancl", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: {
            txtNewsFiels in
            txtNewsFiels.placeholder = "Type the news here."
        })
        
        alert.addAction(UIAlertAction(title: "Push", style: .default, handler: {
            btnPush in
            if let news = alert.textFields?.first{
                print(news)
            }
        }))
        
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
}
