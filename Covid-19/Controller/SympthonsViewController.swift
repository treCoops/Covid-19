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
    @IBOutlet weak var feverSegment: UISegmentedControl!
    @IBOutlet weak var troathSegment: UISegmentedControl!
    @IBOutlet weak var coughSegment: UISegmentedControl!
    
    var firebaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    
    var latitiude: Double = 0;
    var longtitude: Double = 0;
    
    let score = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        level1View.roundView()
        level2View.roundView()
        level3View.roundView()
        
        firebaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hideNavigationBar()
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        
        let feverScore = score[feverSegment.selectedSegmentIndex]
        let troathScore = score[troathSegment.selectedSegmentIndex]
        let coughScore = score[coughSegment.selectedSegmentIndex]
        
        let score = feverScore + troathScore + coughScore
        
        firebaseManager.saveSympthonsData(score: score)
        indicatorHUD.show()
        
    }
}

extension SympthonsViewController : FirebaseActions {
     
    func operationSuccess() {
        self.present(PopupDialog.generateAlert(title: "Success", msg: "Status Updated!"), animated: true)
        indicatorHUD.hide()
    }
    
    func operationFailed(error: Error) {
        print("Error: \(error)")
        self.present(PopupDialog.generateAlert(title: "Error", msg: error.localizedDescription), animated: true)
        indicatorHUD.hide()
    }
     
 }


