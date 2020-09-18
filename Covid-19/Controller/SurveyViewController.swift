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
        
        tblViewSurvey.register(UINib(nibName: XIBIdentifier.XIB_SURVEY, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_SURVEY_CELL)
        
        fireabaseManager.getSurveyData()
        indicatorHUD.show()
    }
    
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        
    
        if sender.selectedSegmentIndex == 1 {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            for i in (0..<surveys.count){
                surveys[i].dateValue = formatter.date(from: surveys[i].date)!
            }
            
            surveys = surveys.sorted(by: {
                $0.date.compare($1.date) == .orderedDescending
            })
            tblViewSurvey.reloadData()
           
        }else{
            surveys = surveys.sorted(by: {
                $0.score > $1.score
            })
            tblViewSurvey.reloadData()
            
        }
 
    }
    
}


extension SurveyViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tblViewSurvey.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_SURVEY_CELL, for: indexPath) as! SurveyTableViewCell
        row.configXIB(data: surveys[indexPath.row])
        
        return row
    }


}

extension SurveyViewController : FirebaseActions{
    func onServeyDataLoaded(survey: [Survey]) {
        print(survey)
        surveys.removeAll()
        surveys.append(contentsOf: survey)
        surveys = surveys.sorted(by: {
            $0.score > $1.score
        })
        
        tblViewSurvey.reloadData()
        indicatorHUD.hide()
    }

    func operationFailed(error: Error) {
        indicatorHUD.hide()
    }

}
