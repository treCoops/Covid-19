//
//  SurveyTableViewCell.swift
//  Covid-19
//
//  Created by treCoops on 9/18/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtNIC: UILabel!
    @IBOutlet weak var txtRole: UILabel!
    @IBOutlet weak var txtScore: UILabel!
    @IBOutlet weak var imgIndicator: UIImageView!
    @IBOutlet weak var viewHolder: UIView!
    @IBOutlet weak var txtDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    
    func configXIB(data: Survey){
        viewHolder.layer.cornerRadius = self.frame.height / 15
        self.clipsToBounds = true
        txtName.text = data.name
        txtNIC.text = data.nic
        txtDate.text = data.date
        txtRole.text = data.role+"  "
        txtScore.text = String(data.score)
        imgProfilePic.roundImageView()
        imgProfilePic.kf.setImage(with: URL(string: data.profilePicUirl))
        
        if data.score <= 4{
            imgIndicator.image = #imageLiteral(resourceName: "level_green")
        } else if data.score <= 6 {
            imgIndicator.image = #imageLiteral(resourceName: "level_yellow")
        } else if data.score <= 7 {
            imgIndicator.image = #imageLiteral(resourceName: "level_orange")
        } else if data.score <= 9 {
            imgIndicator.image = #imageLiteral(resourceName: "level_red")
        }
        
    }
    
}


