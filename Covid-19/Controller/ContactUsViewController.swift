//
//  ContactUsViewCellViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/19/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        mainView.roundView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }
    
    @IBAction func btnCallPressed(_ sender: UIButton) {
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
        
    }
    

    @IBAction func btnSendSmsPressed(_ sender: UIButton) {
        
        if let name : String = UserSession.getUserDefault(key: UserRelated.userName){
        
            let sms: String = "sms:+94111111117&body=Hello, I am \(name)..."
            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
            
        }
    }
}

