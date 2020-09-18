//
//  SurveyViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    var surveys : [Survey] = []
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    @IBOutlet weak var tblViewSurvey: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1))
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
        tblViewSurvey.register(UINib(nibName: "SurveyTableViewCell", bundle: nil), forCellReuseIdentifier: "ReuseableCell")
        
        fireabaseManager.getSurveyData()
        indicatorHUD.show()
    }

}


extension SurveyViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tblViewSurvey.dequeueReusableCell(withIdentifier: "ReuseableCell", for: indexPath) as! SurveyTableViewCell
        row.configXIB(data: surveys[indexPath.row])
        
        return row
    }


}

extension SurveyViewController : FirebaseActions{
    func onServeyDataLoaded(survey: [Survey]) {
        print(survey)
        surveys.removeAll()
        surveys.append(contentsOf: survey)
        tblViewSurvey.reloadData()
        indicatorHUD.hide()
    }

    func operationFailed(error: Error) {
        indicatorHUD.hide()
    }

}
