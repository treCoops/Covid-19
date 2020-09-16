//
//  FirebaseManager.swift
//  Covid-19
//
//  Created by treCoops on 9/16/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthManager{
    
    var delegete: FirebaseAuthActions?
    
    func createUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: {
            authResult, error in
            if let error = error{
                self.delegete?.failedAuthetication(error: error)
            }else{
                self.delegete?.doneAuthentication(uid: authResult?.user.uid)
            }
        })
    }
}

protocol FirebaseAuthActions {
    func doneAuthentication(uid: String?)
    func failedAuthetication(error: Error)
}

extension FirebaseAuthActions {
    func doneAuthentication(uid: String?){}
    
    func failedAuthetication(error: Error){}
}
