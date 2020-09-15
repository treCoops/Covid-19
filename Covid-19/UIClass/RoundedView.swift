//
//  roundedView.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

import UIKit

extension UIView{
    
    func roundView(){
        self.layer.cornerRadius = self.frame.height / 20
        self.clipsToBounds = true
    }
    
}
