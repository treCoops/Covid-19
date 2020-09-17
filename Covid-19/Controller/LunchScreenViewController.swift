//
//  LunchScreenViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/17/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class LunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let loggedIn : Bool = UserSession.getUserDefault(key: UserRelated.userLogged){
            if loggedIn {
                performSegue(withIdentifier: Seagus.splashToHome, sender: nil)
            }else{
                performSegue(withIdentifier: Seagus.splashToLogin, sender: nil)
            }
        }else{
            performSegue(withIdentifier: Seagus.splashToLogin, sender: nil)
        }
    }
    
}
