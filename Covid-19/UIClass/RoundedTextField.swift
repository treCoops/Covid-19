//
//  RoundedTextField.swift
//  Covid-19
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

  override init(frame: CGRect) {
         super.init(frame: frame)
         setupButton()
     }
     
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupButton()
     }
     
     
     private func setupButton() {
         layer.cornerRadius  = frame.size.height/2
     }
}
