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
    
    var imagePicker : ImagePicker!
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    var validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let gestureRecognizion = UITapGestureRecognizer(target: self, action: #selector(self.pickImage))
        self.imgProfilePic.addGestureRecognizer(gestureRecognizion)
        
        indicatorHUD = IndicatorHUD(view: view)
    }
    
    @objc
    func pickImage(_ sender: UIImageView){
       self.imagePicker.present(from: sender)
    }
    

    @IBAction func btnNamePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnEmailPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func btnpasswordChanged(_ sender: UIButton) {
        
    }
    
    @IBAction func btnViewResultPressed(_ sender: UIButton) {
        
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
    }
}

extension SettingViewController : FirebaseActions{
    func operationFailed(error: Error) {
        self.present(PopupDialog.generateAlert(title: "Error", msg: error.localizedDescription), animated: true)
    }
}
