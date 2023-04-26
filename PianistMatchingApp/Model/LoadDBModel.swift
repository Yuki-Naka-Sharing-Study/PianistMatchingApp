//
//  LoadDBModel.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/25.
//

import Foundation
import Firebase

protocol GetProfileDataProtocol {
    
    func getProfileData(userDataModelArray:[UserDataModel])
    
}

class LoadDBModel {
    
    var db = Firestore.firestore()
    var profileModelArray = [UserDataModel]()
    var getProfileDataProtocol:GetProfileDataProtocol?
    // ユーザーデータを受信する
    func loadUsersProfile(gender:String){
        
        db.collection("Users").whereField("gender", isNotEqualTo: gender).addSnapshotListener { snapShot, error in
            
            if error != nil {
                
                print(error.debugDescription)
                return
                
            }
            
            if let snapShotDoc = snapShot?.documents {
                
                self.profileModelArray = []
                for doc in snapShotDoc {
                    
                    let data = doc.data()
                    if let name = data["name"] as? String,
                       let age = data["age"] as? String,
                       let height = data["height"] as? String,
                       let bloodType = data["bloodType"] as? String,
                       let prefecture = data["prefecture"] as? String,
                       let gender = data["gender"] as? String,
                       let profile = data["profile"] as? String,
                       let profileImageString = data["profileImageString"] as? String,
                       let uid = data["uid"] as? String,
                       let quickWord = data["quickWord"] as? String,
                       let work = data["work"] as? String,
                       let onlineORNot = data["onlineORNot"] as? Bool{
                        
                       let userDataModel = UserDataModel(name: name, age: age, height: height, bloodType: bloodType, prefecture: prefecture, gender: gender, profile: profile, profileImageString: profileImageString, uid: uid, quickWord: quickWord, work: work, date: 0, onlineORNot: onlineORNot)
                        
                        self.profileModelArray.append(userDataModel)
                        
                    }
                    
                }
                
                self.getProfileDataProtocol?.getProfileData(userDataModelArray: self.profileModelArray)
                
            }
            
        }
        
    }
    
}
