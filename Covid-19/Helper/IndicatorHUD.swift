//
//  IndicatorHUD.swift
//  Covid-19
//
//  Created by treCoops on 9/17/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class IndicatorHUD{
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    var view : UIView
    
    init(view : UIView) {
        self.view = view
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
    }
    
    func show(){
        
        activityIndicator.backgroundColor = UIColor.systemGray4
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.isUserInteractionEnabled = false
    }
    
    func hide(){
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        view.isUserInteractionEnabled = true
        
    }
    
}
