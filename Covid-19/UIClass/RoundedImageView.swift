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
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
    }
}
