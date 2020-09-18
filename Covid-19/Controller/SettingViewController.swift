//
//  SettingViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class SettingViewController: UIViewController {
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtRole: UILabel!
    @IBOutlet weak var btnViewSurveyResult: UIButton!
    
    var imagePicker : ImagePicker!
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let role : String = UserSession.getUserDefault(key: UserRelated.userType){
            if role == "STUDENT"{
                btnViewSurveyResult.isEnabled = false
                btnViewSurveyResult.setTitleColor(UIColor.init(cgColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), for: .normal)
            }
        }
        
        if let imageURL : String = UserSession.getUserDefault(key: UserRelated.userProfilePic){
            let url = URL(string: imageURL)
            imgProfilePic.kf.setImage(with: url)
        }
        
        if let name : String = UserSession.getUserDefault(key: UserRelated.userName){
            txtName.text = name
        }
        
        if let email : String = UserSession.getUserDefault(key: UserRelated.userEmail){
            txtEmail.text = email
        }
        
        if let role : String = UserSession.getUserDefault(key: UserRelated.userType){
            txtRole.text = role+"  "
        }
        
        fireabaseManager.delegete = self

        imgProfilePic.roundImageView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let gestureRecognizion = UITapGestureRecognizer(target: self, action: #selector(self.pickImage))
        self.imgProfilePic.addGestureRecognizer(gestureRecognizion)
        
        indicatorHUD = IndicatorHUD(view: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let imageURL : String = UserSession.getUserDefault(key: UserRelated.userProfilePic){
            let url = URL(string: imageURL)
            imgProfilePic.kf.setImage(with: url)
        }
    }
    
    @objc
    func pickImage(_ sender: UIImageView){
       self.imagePicker.present(from: sender)
    }
    

    @IBAction func btnNamePressed(_ sender: UIButton) {
        let alert = PopupDialog.generatePopupAlert(title: "Update Name", message: "Enter your new name to update!", type: "NAME")
        
        let action = UIAlertAction(title: "Update", style: .default, handler: {
            action in
            if let name = alert.textFields?.first {
                self.indicatorHUD.show()
                self.fireabaseManager.updateName(name: name.text!)
                
            }
        })
        action.isEnabled = false;
        alert.addAction(action)
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.first, queue: OperationQueue.main, using: {
            notification in
            
            if !self.validator.isValidName(alert.textFields?.first?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid name!"
            } else {
                action.isEnabled = true
                alert.message = "Click update to submit!"
            }
            
        })
        
        self.present(alert, animated: true)
    }
    
    @IBAction func btnEmailPressed(_ sender: UIButton) {
        let alert = PopupDialog.generatePopupAlert(title: "Update Email", message: "Enter your new email to update. This operation required logout, This will logout automatically!", type: "EMAIL")

        let action = UIAlertAction(title: "Update", style: .default, handler: {
            action in
            if let email = alert.textFields?.first {
                self.indicatorHUD.show()
                self.fireabaseManager.updateEmail(email: email.text!)
                self.fireabaseManager.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        action.isEnabled = false;
        alert.addAction(action)
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.first, queue: OperationQueue.main, using: {
            notification in
            
            if self.validator.isEmpty(alert.textFields?.first?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid email!"
            } else if !self.validator.isValidEmail(alert.textFields?.first?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid email!"
            } else {
                action.isEnabled = true
                alert.message = "Click update to submit. This operation required logout, This will logout automatically!"
            }
            
        })
        

        self.present(alert, animated: true)
    }
    
    @IBAction func btnpasswordChanged(_ sender: UIButton) {
        let alert = PopupDialog.generatePopupAlert(title: "Update Password", message: "Enter your new password to update. This operation required logout, This will logout automatically!", type: "PASSWORD")

        let action = UIAlertAction(title: "Update", style: .default, handler: {
            action in
            if let password = alert.textFields?.first {
                self.indicatorHUD.show()
                self.fireabaseManager.updatePassword(password: password.text!)
                self.fireabaseManager.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
        action.isEnabled = false;
        alert.addAction(action)
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.first, queue: OperationQueue.main, using: {
            notification in
            
            if self.validator.isEmpty(alert.textFields?.first?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid password!"
                
            } else if !self.validator.checkLenght(alert.textFields?.last?.text ?? "", 6) {
               action.isEnabled = false
               alert.message = "Password must have 6 characters!"
               
            } else if !self.validator.isEqual(alert.textFields?.first?.text ?? "", alert.textFields?.last?.text ?? "") {
                action.isEnabled = false
                alert.message = "Password and Confirm password are not same!"
            }else{
                
                action.isEnabled = true
                alert.message = "Click update to submit. This operation required logout, This will logout automatically!"
            }
            
        })
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?.last, queue: OperationQueue.main, using: {
            notification in
            
            if self.validator.isEmpty(alert.textFields?.last?.text ?? "") {
                action.isEnabled = false
                alert.message = "Enter a valid password!"
            } else if !self.validator.checkLenght(alert.textFields?.last?.text ?? "", 6) {
                action.isEnabled = false
                alert.message = "Password must have 6 characters!"
            } else if !self.validator.isEqual(alert.textFields?.first?.text ?? "", alert.textFields?.last?.text ?? "") {
                action.isEnabled = false
                alert.message = "Password and Confirm password are not same!"
            } else
                {
                action.isEnabled = true
                alert.message = "Click update to submit. This operation required logout, This will logout automatically!"
            }
            
        })

        self.present(alert, animated: true)
    }
    
    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        
        let alert = PopupDialog.generateAlertWithoutButton(title: "Logout", msg: "Are you sure, you want to logout from the application?")
               
            alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: {
                action in
                self.fireabaseManager.signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
               
            self.present(alert, animated: true)
        
    }
    
}

extension SettingViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
        if image == nil {
            imgProfilePic.image = #imageLiteral(resourceName: "User")
            return
        }
        
        self.imgProfilePic.image = image
        
        if let image: UIImage = image{
            fireabaseManager.changeProfilePic(image: image)
            indicatorHUD.show()
        }
        
    }
}

extension SettingViewController : FirebaseActions{
    func operationFailed(error: Error) {
        self.present(PopupDialog.generateAlert(title: "Error", msg: error.localizedDescription), animated: true)
        indicatorHUD.hide()
    }
    
    func operationSuccess() {
        self.present(PopupDialog.generateAlert(title: "Success", msg: "Data Updated Successfully!"), animated: true)
        
        if let name : String = UserSession.getUserDefault(key: UserRelated.userName){
            txtName.text = name
        }
        
        if let email : String = UserSession.getUserDefault(key: UserRelated.userEmail){
            txtEmail.text = email
        }
        
        indicatorHUD.hide()
    }
}

