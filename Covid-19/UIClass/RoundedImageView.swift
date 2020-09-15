//
//  RoundedImageView.swift
//  Covid-19
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

extension UIImageView{
    func roundImageView(){
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = #colorLiteral(red: 0.0227817148, green: 0.215121001, blue: 0.2304691374, alpha: 1)
        self.layer.masksToBounds = false
    }
}
