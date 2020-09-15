//
//  SettingViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgProfilePic.roundImageView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    

   

}
