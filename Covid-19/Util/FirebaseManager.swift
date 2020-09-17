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
        if let uid: String = UserSession.getUserDefault(key: UserRelated.userUID), let name: String = UserSession.getUserDefault(key: UserRelated.userName), let nic: String = UserSession.getUserDefault(key: UserRelated.userNIC), let role: String =  UserSession.getUserDefault(key: UserRelated.userType){
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let userRelatedData = [
                "fullName": name,
                "nic": nic,
                "role": role,
                "score": score,
                "updatedDate": dateFormatter.string(from: Date())
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
    
    
}

protocol FirebaseActions {
    func operationSuccess(uid: String?)
    func operationFailed(error: Error)
    func operationSuccess()
    
    func firebaseError(error: String)
    
    func userDataLoaded(user : User)
    func userDataNotLoaded(error: Error)
}

extension FirebaseActions {
    func operationSuccess(uid: String?){}
    func operationFailed(error: Error){}
    func operationSuccess(){}
    
    func firebaseError(error: String){}
    
    func userDataLoaded(user : User){}
    func userDataNotLoaded(error: Error){}
}
