//
//  SympthonsViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SympthonsViewController: UIViewController {
    @IBOutlet weak var level1View: UIView!
    @IBOutlet weak var level2View: UIView!
    @IBOutlet weak var level3View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        

        level1View.roundView()
        level2View.roundView()
        level3View.roundView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }
    

}
