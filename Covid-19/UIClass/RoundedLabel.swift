//
//  RoundedLabel.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation


import UIKit

class RoundedLabel: UILabel {

     override init(frame: CGRect) {
           super.init(frame: frame)
           setupLabel()
       }
       
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           setupLabel()
       }
       
       
       private func setupLabel() {
           layer.cornerRadius = self.frame.height / 2.5
           layer.masksToBounds = true
       }

}
