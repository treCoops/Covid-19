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
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideNavigationBar()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        fireabaseManager.delegete = self
        indicatorHUD = IndicatorHUD(view: view)
        
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
        
        fireabaseManager.signInUser(email: txtEmail.text ?? "", password: txtPassword.text ?? "")
        indicatorHUD.show()
    }
    
}

extension LoginViewController : FirebaseActions{
    
    func operationSuccess(uid: String?) {
        print("UID: \(uid ?? "")")
        fireabaseManager.retrieveUserData(uid: uid)
    }
    
    func operationFailed(error: Error) {
        print("Error: \(error)")
        self.present(PopupDialog.generateAlert(title: "SignIn Error", msg: error.localizedDescription), animated: true)
        indicatorHUD.hide()
        
    }
    
    func userDataLoaded(user: User) {
        UserSession.saveUserData(user: user)
        performSegue(withIdentifier: Seagus.loginToHome, sender: nil)
        indicatorHUD.hide()
    }
    
    func userDataNotLoaded(error: Error) {
        print("Error: \(error)")
        self.present(PopupDialog.generateAlert(title: "User Data Error", msg: error.localizedDescription), animated: true)
        indicatorHUD.hide()
    }
    
    func firebaseError(error: String) {
        print("Error: \(error)")
        indicatorHUD.hide()
        self.present(PopupDialog.generateAlert(title: "User Data Error", msg: error), animated: true)
    }
    
}




