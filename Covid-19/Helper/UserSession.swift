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
}
