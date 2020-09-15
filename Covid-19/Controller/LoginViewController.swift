//
//  ViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideNavigationBar()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if validator.isEmpty(txtEmail.text ?? "") {
            txtEmail.attributedPlaceholder = NSAttributedString(string: "Enter e-Mail!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        if validator.isEmpty(txtPassword.text ?? "") {
            txtPassword.attributedPlaceholder = NSAttributedString(string: "Enter password!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.isValidEmail(txtEmail.text!){
            txtEmail.text = ""
            txtEmail.attributedPlaceholder = NSAttributedString(string: "Enter a valid e-Mail!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.checkLenght(txtPassword.text!, 6){
            txtPassword.text = ""
            txtPassword.attributedPlaceholder = NSAttributedString(string: "Minimum lenght is 6!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
    }
    
}

