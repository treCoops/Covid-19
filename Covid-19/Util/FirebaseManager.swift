//
//  FirebaseManager.swift
//  Covid-19
//
//  Created by treCoops on 9/16/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager{
    
    var delegete: FirebaseActions?
    
    func signInUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            authResult, error in
            if let error = error{
                self.delegete?.operationFailed(error: error)
            }else{
                self.delegete?.operationSuccess(uid: authResult?.user.uid)
            }
        })
    }
    
    func createUser(email: String, password: String, name: String, nic: String, proPic: UIImage?, role: String){
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            authResult, error in
            if let error = error{
                self.delegete?.operationFailed(error: error)
            }else{
                if let uid = authResult?.user.uid{
                    
                    let User = [
                        "uid": uid,
                        "fullName": name,
                        "emailAddress": email,
                        "nic": nic,
                        "profileUrl": "url",
                        "role": role
                    ]
                    
                    self.saveUserInDB(data: User)
                    
                    
                }
            }
        })
    }
    
    func getDBReference() -> DatabaseReference{
        return Database.database().reference()
    }
    
    func saveUserInDB(data: Dictionary<String,String>){
        let dbRef = self.getDBReference()
        dbRef.child("Users").child(data["role"] ?? "default").child(data["uid"] ?? "default").setValue(data) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                self.delegete?.operationFailed(error: error)
            }else{
                self.delegete?.operationSuccess()
            }
        }
    }
    
    
}

protocol FirebaseActions {
    func operationSuccess(uid: String?)
    func operationFailed(error: Error)
    func operationSuccess()
}

extension FirebaseActions {
    func operationSuccess(uid: String?){}
    func operationFailed(error: Error){}
    func operationSuccess(){}
}
