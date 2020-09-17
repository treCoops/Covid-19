//
//  UserSession.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation

class UserSession {
    
    static func setUserDefault(data: String, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func setUserDefault(data: Bool, key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    static func removeUserDefault(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func getUserDefault(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func getUserDefault(key: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    static func getUserData() -> User{
        
        let name = UserDefaults.standard.string(forKey: UserRelated.userName) ?? ""
        let email = UserDefaults.standard.string(forKey: UserRelated.userEmail) ?? ""
        let profilePicUrl = UserDefaults.standard.string(forKey: UserRelated.userProfilePic) ?? ""
        let nic = UserDefaults.standard.string(forKey: UserRelated.userNIC) ?? ""
        let role = UserDefaults.standard.string(forKey: UserRelated.userType) ?? ""
        let uid = UserDefaults.standard.string(forKey: UserRelated.userUID) ?? ""
       
        return User(name: name, email: email, nic: nic, role: role, profilePicUrl: profilePicUrl, uid: uid)
    }
    
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: UserRelated.userName)
        UserDefaults.standard.removeObject(forKey: UserRelated.userEmail)
        UserDefaults.standard.removeObject(forKey: UserRelated.userProfilePic)
        UserDefaults.standard.removeObject(forKey: UserRelated.userNIC)
        UserDefaults.standard.removeObject(forKey: UserRelated.userType)
        UserDefaults.standard.set(false, forKey: UserRelated.userLogged)
        UserDefaults.standard.removeObject(forKey: UserRelated.userUID)
    }
    
    static func saveUserData(user: User){
        UserDefaults.standard.set(user.name, forKey: UserRelated.userName)
        UserDefaults.standard.set(user.email, forKey: UserRelated.userEmail)
        UserDefaults.standard.set(user.profilePicUrl, forKey: UserRelated.userProfilePic)
        UserDefaults.standard.set(user.nic, forKey: UserRelated.userNIC)
        UserDefaults.standard.set(user.role, forKey: UserRelated.userType)
        UserDefaults.standard.set(user.uid, forKey: UserRelated.userUID)
        UserDefaults.standard.set(true, forKey: UserRelated.userLogged)
    }
}
