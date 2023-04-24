//
//  UserDataModel.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/23.
//

import Foundation

// 比較可能なプロトコルに準拠させておく
struct UserDataModel:Equatable {
    
    let name:String?
    let age:String?
    let height:String?
    let bloodType:String?
    let prefecture:String?
    let gender:String?
    let profile:String?
    let profileImageString:String?
    let uid:String?
    let quickWord:String?
    let work:String?
    let date:Double?
    let onlineORNot:Bool?
    
}
