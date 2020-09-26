//
//  Constraints.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import Foundation

struct Seagus {
    static var loginToHome = "loginToHome"
    static var sympthonsSegue = "sympthonsSegue"
    static var splashToLogin = "splashToLogin"
    static var splashToHome = "splashToHome"
    static var splashToBiometrics = "splashToBiometrics"
    static var biometricsToHome = "biometricsToHome"
}

struct UserRelated {
    static var userEmail = "USER_EMAIL"
    static var userName = "USER_NAME"
    static var userNIC = "USER_NIC"
    static var userType = "USER_TYPE"
    static var userLogged = "USER_LOGGED"
    static var userProfilePic = "USER_PROFILE_PICTURE"
    static var userUID = "USER_UID"
    static var userBiometricsLogin = "USER_BIOMETRIC_LOGIN"
}

struct UserRole {
    static var USER_TYPE_STUDENT = "STUDENT"
    static var USER_TYPE_STAFF = "STAFF"
}

struct XIBIdentifier {
    static var XIB_SURVEY_CELL = "ReuseableCell"
    static var XIB_SURVEY = "SurveyTableViewCell"
    
    static var XIB_NEWS_CELL = "newsCellReuseable"
}
