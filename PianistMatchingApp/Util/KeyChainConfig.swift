//
//  KeyChainConfig.swift
//  PianistMatchingApp
//
//  Created by 仲優樹 on 2023/04/25.
//

import Foundation
import KeychainSwift

class KeyChainConfig{
    
    static func getKeyData(key:String)->String{
        
        let keychain = KeychainSwift()
        let keyString = keychain.get(key)
        return keyString!
        
    }
    
    static func setKeyData(value:[String:Any],key:String){
        
        let keychain = KeychainSwift()
        // 配列をデータ化
        let archivedData = try! NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        keychain.set(archivedData, forKey: key)
        
    }
    
    static func getKeyArrayData(key:String)->[String:Any]{
        
        let keychain = KeychainSwift()
        let keyData = keychain.getData(key)
        if keyData != nil{
            
            let unarchivedObject = try! NSKeyedUnArchiver.unarchiveTopLevelObjectWithData(keyData!)
            as! [String:Any]
            return unarchivedObject
            
        }else{
            
            return [ : ]
            
        }
        
    }
    
}
