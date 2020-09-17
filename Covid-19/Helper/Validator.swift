//
//  Validator.swift
//  Covid-19
//
//  Created by treCoops on 9/14/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

struct Validator{
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: email)
    }
    
    func checkLenght(_ text: String, _ count: Int) -> Bool{
        if text.count >= count {
            return true
        }else{
            return false
        }
    }
    
    func isEmpty(_ text: String) -> Bool {
        if text == ""{
            return true
        }else{
            return false
        }
    }
    
    
    func isValidNIC(_ nic: String) -> Bool {
        let NICRegEx = "^([0-9]{9}[x|X|v|V]|[0-9]{12})$"
        let NicPred = NSPredicate(format:"SELF MATCHES %@", NICRegEx)

        return NicPred.evaluate(with: nic)
    }
    
    func isValidName(_ name: String) -> Bool{
        let nameRegEx = "[A-Za-z ]{2,50}"
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)

        return namePred.evaluate(with: name)
    }
    
    func isEqual(_ one: String, _ two: String) -> Bool {
        if(one == two){
            return true
        }else{
            return false
        }
    }
    
}
