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
    
    func show(view : UIView){
        activityIndicator.backgroundColor = UIColor.systemGray4
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        view.isUserInteractionEnabled = false
    }
    
    func hide(view : UIView){
        
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        view.isUserInteractionEnabled = true
        
    }
    
}
