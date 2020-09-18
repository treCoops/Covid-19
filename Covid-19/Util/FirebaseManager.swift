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
                    
                    self.uploadProfilePic(image: proPic!, data: User)
                    
                }
            }
        })
    }
    
    func getDBReference() -> DatabaseReference{
        return Database.database().reference()
    }
    
    func getStorageReference() -> StorageReference{
        return Storage.storage().reference()
    }
    
    func saveUserInDB(data: Dictionary<String,String>){
        let dbRef = self.getDBReference()
        dbRef.child("Users").child(data["uid"] ?? "default").setValue(data) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                self.delegete?.operationFailed(error: error)
            }else{
                self.delegete?.operationSuccess()
            }
        }
    }
    
    func uploadProfilePic(image: UIImage, data: Dictionary<String, String>){
        
        if let uploadImage = image.jpegData(compressionQuality: 0.5){
            let storageRef = self.getStorageReference()
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            storageRef.child("userProfilePics").child(data["nic"] ?? "").putData(uploadImage, metadata: metaData) { (metadata, error) in

              storageRef.child("userProfilePics").child(data["nic"] ?? "").downloadURL { (url, error) in
                    if let error = error {
                        self.delegete?.operationFailed(error: error)
                    }
                    guard let downloadURL = url else {
                        
                        let user = Auth.auth().currentUser

                        user?.delete { error in
                          if let error = error {
                            print("User Delete Error \(error.localizedDescription)")
                          }
                        }

                        return
                    }
                    
                    var User = data
                    User["profileUrl"] = downloadURL.absoluteString
                    self.saveUserInDB(data: User)
                }
            }
            
        }
        
    }
    
    func changeProfilePic(image: UIImage){
        if let uploadImage = image.jpegData(compressionQuality: 0.5){
            let storageRef = self.getStorageReference()
            let dbRef = self.getDBReference()
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID), let nic: String = UserSession.getUserDefault(key: UserRelated.userNIC){
            
                storageRef.child("userProfilePics").child(nic).putData(uploadImage, metadata: metaData) { (metadata, error) in

                  storageRef.child("userProfilePics").child(nic).downloadURL { (url, error) in
                        if let error = error {
                            self.delegete?.operationFailed(error: error)
                        }
                        guard let downloadURL = url else {
                            return
                        }
                        
                        UserSession.setUserDefault(data: downloadURL.absoluteString, key: UserRelated.userProfilePic)
                        
                        dbRef.child("Users").child(uid).child("profileUrl").setValue(downloadURL.absoluteString) {
                            (error: Error?, ref: DatabaseReference) in
                            if let error = error {
                                self.delegete?.operationFailed(error: error)
                            }else{
                                self.delegete?.operationSuccess()
                            }
                        }

                   
                    }
                }
            }
            
        }
    }
    
    func updateName(name: String){
        
        let dbRef = self.getDBReference()
        
        if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID){

            dbRef.child("Users").child(uid).child("fullName").setValue(name) {
                (error: Error?, ref: DatabaseReference) in
                if let error = error {
                    self.delegete?.operationFailed(error: error)
                }else{
                    UserSession.setUserDefault(data: name, key: UserRelated.userName)
                    self.delegete?.operationSuccess()
                }
            }
        
        }
    }
    
    func updateEmail(email: String){
        let dbRef = self.getDBReference()
        
        if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID){
            Auth.auth().currentUser?.updateEmail(to: email) { (error) in
                if let error = error {
                     self.delegete?.operationFailed(error: error)
                }else{
                    
                    dbRef.child("Users").child(uid).child("emailAddress").setValue(email) {
                        (error: Error?, ref: DatabaseReference) in
                        if let error = error {
                            self.delegete?.operationFailed(error: error)
                        }else{
                            UserSession.setUserDefault(data: email, key: UserRelated.userEmail)
                            self.delegete?.operationSuccess()
                        }
                    }
                    
                }
            }

        }
        
    }
    
    func updatePassword(password: String){
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error = error {
                self.delegete?.operationFailed(error: error)
            }else{
                self.delegete?.operationSuccess()
            }
        }

    }
    
    func retrieveUserData(uid: String?){
        let dbRef = self.getDBReference()
        
        if let uid = uid{
            dbRef.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let user = snapshot.value as? [String : String]{
                    self.delegete?.userDataLoaded(user:
                        User(name: user["fullName"]!,
                             email: user["emailAddress"]!,
                             nic: user["nic"]!,
                             role: user["role"]!,
                             profilePicUrl: user["profileUrl"]!,
                             uid: user["uid"]!))
                }else{
                    self.delegete?.firebaseError(error: "Data retrieve failed!")
                }
            
              }) { (error) in
                print("Error \(error.localizedDescription)")
                self.delegete?.userDataNotLoaded(error: error)
            }
        }

    }
    
    func saveSympthonsData (score: Int){
        
        let dbRef = self.getDBReference()
        if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID), let name: String = UserSession.getUserDefault(key: UserRelated.userName), let nic: String = UserSession.getUserDefault(key: UserRelated.userNIC), let role: String =  UserSession.getUserDefault(key: UserRelated.userType), let profilePic: String = UserSession.getUserDefault(key: UserRelated.userProfilePic){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let userRelatedData = [
                "fullName": name,
                "nic": nic,
                "role": role,
                "score": score,
                "updatedDate": dateFormatter.string(from: Date()),
                "profilePicUrl": profilePic
            ] as [String : Any]
            
            dbRef.child("UserRelatedData").child(uid).setValue(userRelatedData) {
                (error: Error?, ref: DatabaseReference) in
                if let error = error {
                    self.delegete?.operationFailed(error: error)
                }else{
                    self.delegete?.operationSuccess()
                }
            }
        }
    }
    
    func pushNews(news: String){
        let dbRef = self.getDBReference()
        guard let key = dbRef.child("Notifications").childByAutoId().key else { return }
        dbRef.child("Notifications").child(key).child("news").setValue(news) {
            (error: Error?, ref: DatabaseReference) in
            if let error = error {
                self.delegete?.operationFailed(error: error)
            }else{
                self.delegete?.operationSuccess()
            }
        }
    }
    
    func saveTempData(temp: Double, lat: Double, long: Double, notify: Bool){
        let dbRef = self.getDBReference()
        if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let userTempData = [
                "uid": uid,
                "temp": temp,
                "lat": lat,
                "long": long,
                "updatedDate": dateFormatter.string(from: Date())
                ] as [String : Any]
            
            dbRef.child("UserTempData").child(uid).setValue(userTempData) {
                (error: Error?, ref: DatabaseReference) in
                if let error = error {
                    self.delegete?.operationFailed(error: error)
                }else{
                    if notify{
                        self.delegete?.operationSuccessTemp()
                    }
                }
            }
        }
    }
    
    func getNewsData(){
        var news : [String] = []
        let ref = self.getDBReference()
        var initialRead = true
        
        ref.child("Notifications").observe(.childAdded, with: {
            snapshot in
            if initialRead == false {
                if let newsDict = snapshot.value as? [String : Any] {
                    let data = newsDict["news"] as! String
                    news.append(data)
                    self.delegete?.onNewsDataLoaded(news: news)
                }
            }
            
        })
        
        ref.child("Notifications").observeSingleEvent(of: .value, with: { snapshot in
            
            initialRead = false
            
            if let newsDict = snapshot.value as? [String: Any] {
                for (_,value) in newsDict {
                    guard let innerDict = value as? [String: Any] else {
                        continue
                    }
                    news.append(innerDict["news"] as! String)
                }

                self.delegete?.onNewsDataLoaded(news: news)
            }
        })
        
        
    }
    
    func getLocationUpdates(){
        var mapLocation : [MapLocations] = []
        let ref = self.getDBReference()
        
        ref.child("UserTempData").observe(.childChanged, with: {
            snapshot in
            
            ref.child("UserTempData").observeSingleEvent(of: .value, with: { snapshot in
                
                mapLocation.removeAll()
                
                if let dict = snapshot.value as? [String: Any] {
                    for loc in dict{
                        guard let innerDict = loc.value as? [String: Any] else {
                            continue
                        }
            
                        mapLocation.append(MapLocations(temp: innerDict["temp"] as! Double, lat: innerDict["lat"] as! Double, long: innerDict["long"] as! Double, uid: innerDict["uid"] as! String, updatedDate: innerDict["updatedDate"] as! String))
                    }
                    
                    self.delegete?.onLocationDataLoaded(mapLocation: mapLocation)
                }
                
            })
            
        })
        
        ref.child("UserTempData").observeSingleEvent(of: .value, with: { snapshot in
            
            if let Dict = snapshot.value as? [String: Any] {
                
                for (_,value) in Dict {
                    guard let innerDict = value as? [String: Any] else {
                        continue
                    }
                
                    mapLocation.append(MapLocations(temp: innerDict["temp"] as! Double, lat: innerDict["lat"] as! Double, long: innerDict["long"] as! Double, uid: innerDict["uid"] as! String, updatedDate: innerDict["updatedDate"] as! String))
                    
                }
            

                self.delegete?.onLocationDataLoaded(mapLocation: mapLocation)
            }
        })
    }
    
    func getSurveyData(){
        var surveys: [Survey] = []
        let ref = self.getDBReference()
        
        
        ref.child("UserRelatedData").observeSingleEvent(of: .value, with: { snapshot in
            
            if let Dict = snapshot.value as? [String: Any] {
                
                for (_,value) in Dict {
                    guard let innerDict = value as? [String: Any] else {
                        continue
                    }
                
                    surveys.append(Survey(nic: innerDict["nic"] as! String, profilePicUirl: innerDict["profilePicUrl"] as! String, role: innerDict["role"] as! String, name: innerDict["fullName"] as! String, score: innerDict["score"] as! Int, date: innerDict["updatedDate"] as! String))
                    
                }
            

                self.delegete?.onServeyDataLoaded(survey: surveys)
            }
        }) { (error) in
            self.delegete?.operationFailed(error: error)
        }
        
    }
    
    func signOut(){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserSession.clearUserData()

        } catch let signOutError as NSError {
            self.delegete?.operationFailed(error: signOutError)
        }
          
    }
    
    
}

protocol FirebaseActions {
    func operationSuccess(uid: String?)
    func operationFailed(error: Error)
    func operationSuccess()
    
    func firebaseError(error: String)
    
    func userDataLoaded(user : User)
    func userDataNotLoaded(error: Error)
    
    func operationSuccessTemp()
    
    func onNewsDataLoaded(news : [String])
    func onLocationDataLoaded(mapLocation: [MapLocations])
    func onServeyDataLoaded(survey: [Survey])
}

extension FirebaseActions {
    func operationSuccess(uid: String?){}
    func operationFailed(error: Error){}
    func operationSuccess(){}
    
    func firebaseError(error: String){}
    
    func userDataLoaded(user : User){}
    func userDataNotLoaded(error: Error){}
    
    func operationSuccessTemp(){}
    
    func onNewsDataLoaded(news : [String]){}
    
    func onLocationDataLoaded(mapLocation: [MapLocations]){}
    func onServeyDataLoaded(survey: [Survey]){}
}
