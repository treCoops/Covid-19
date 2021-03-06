//
//  SignUpViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMail: UITextField!
    @IBOutlet weak var txtNIC: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnRoleStudent: UIButton!
    @IBOutlet weak var btnRoleStaff: UIButton!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    var validator = Validator()
    var fireabaseManager = FirebaseManager()
    var indicatorHUD : IndicatorHUD!
    
    var imagePicker : ImagePicker!
    
    var userRole : String = UserRole.USER_TYPE_STUDENT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgProfilePic.roundImageView()
        
        fireabaseManager.delegete = self
        
        txtName.delegate = self
        txtMail.delegate = self
        txtNIC.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.changeNavBarTintColor(tintColor: #colorLiteral(red: 0, green: 0.762951076, blue: 0.4009746909, alpha: 1))
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let gestureRecognizion = UITapGestureRecognizer(target: self, action: #selector(self.pickImage))
        self.imgProfilePic.addGestureRecognizer(gestureRecognizion)
        
        indicatorHUD = IndicatorHUD(view: view)
        
        
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       self.view.endEditing(true)
       return true
    }
    
    @IBAction func rolePressed(_ sender: UIButton) {
        btnRoleStaff.isSelected = false
        btnRoleStudent.isSelected = false
        sender.isSelected = true
        
        if sender.currentTitle == "Staff"{
            userRole = UserRole.USER_TYPE_STAFF
        }else{
            userRole = UserRole.USER_TYPE_STUDENT
        }
    }

    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if validator.isEmpty(txtName.text?.trimmingCharacters(in: .whitespaces) ?? "") {
            txtName.text = ""
            txtName.attributedPlaceholder = NSAttributedString(string: "Enter name!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.isValidName(txtName.text ?? ""){
            txtName.text = ""
            txtName.attributedPlaceholder = NSAttributedString(string: "Enter a valid name!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if validator.isEmpty(txtMail.text ?? "") {
            txtMail.attributedPlaceholder = NSAttributedString(string: "Enter e-Mail!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.isValidEmail(txtMail.text!){
            txtMail.text = ""
            txtMail.attributedPlaceholder = NSAttributedString(string: "Enter a valid e-Mail!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if validator.isEmpty(txtNIC.text ?? "") {
            txtNIC.attributedPlaceholder = NSAttributedString(string: "Enter NIC!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.isValidNIC(txtNIC.text!){
            txtNIC.text = ""
            txtNIC.attributedPlaceholder = NSAttributedString(string: "Enter a valid NIC!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if validator.isEmpty(txtPassword.text ?? "") {
            txtPassword.attributedPlaceholder = NSAttributedString(string: "Enter password!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.checkLenght(txtPassword.text!, 6){
            txtPassword.text = ""
            txtPassword.attributedPlaceholder = NSAttributedString(string: "Minimum lenght is 6!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if validator.isEmpty(txtConfirmPassword.text ?? "") {
            txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Enter confirm password!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
        if !validator.checkLenght(txtConfirmPassword.text!, 6){
            txtConfirmPassword.text = ""
            txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Minimum lenght is 6!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            return
        }
        
      
        if !validator.isEqual(txtPassword.text!, txtConfirmPassword.text!){
            txtPassword.text = ""
            txtPassword.attributedPlaceholder = NSAttributedString(string: "Not match with confirm password!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            
            txtConfirmPassword.text = ""
            txtConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Not match with password!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))])
            
            return
        }
        
        fireabaseManager.createUser(email: txtMail.text ?? "", password: txtPassword.text ?? "", name: txtName.text ?? "", nic: txtNIC.text ?? "", proPic: imgProfilePic.image, role: userRole)
        indicatorHUD.show()
        
    }
    
    @objc
    func pickImage(_ sender: UIImageView){
       self.imagePicker.present(from: sender)
    }
    
}

extension SignUpViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
        if image == nil {
            imgProfilePic.image = #imageLiteral(resourceName: "User")
            return
        }
        
        self.imgProfilePic.image = image
    }
}

extension SignUpViewController : FirebaseActions{
    func operationSuccess() {
        let alert = PopupDialog.generateAlertWithoutButton(title: "Success", msg: "User Created Successfully.!")
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
            action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        
        self.present(alert, animated: true)
        
        indicatorHUD.hide()
    }
    
    func operationFailed(error: Error) {
        print(error)
        self.present(PopupDialog.generateAlert(title: "Error", msg: error.localizedDescription), animated: true)
        
         indicatorHUD.hide()
    }
}
