//
//  KeychainFunctions.swift
//  ActivityPlanningSystem-Frontend
//
//  Created by Ege Kara on 18.02.2025.
//

import Foundation
import Security

let serviceName = "dev.activityPlanner"

//  Save password to keychain
private func saveToKeychain(key : String, value : String) {
    
    let query: [String: Any] = [
        kSecClass as String : kSecClassGenericPassword,
        kSecAttrService as String : serviceName,
        kSecAttrAccount as String : key,
        kSecValueData as String : value.data(using: .utf8)!,
        kSecAttrAccessible as String : kSecAttrAccessibleWhenUnlocked
        ]
    
    let updateStatus = SecItemUpdate(query as CFDictionary, [kSecValueData as String: value.data(using: .utf8)!] as CFDictionary)
    
    if(updateStatus == errSecSuccess){
        print("Başarıyla güncellendi")
        return
    }
    
    SecItemDelete(query as CFDictionary)
    let status = SecItemAdd(query as CFDictionary, nil)
    
    if(status == errSecSuccess){
        print("Value saved successfully")
    }else{
        print("Value save error: \(status)")
    }
}



//  Save password to keychain
func savePasswordKeychain(username : String, password : String) {
    saveToKeychain(key: username, value: password)
}


//  Save jwt token to keychain
func saveTokenKeychain(token : String) {
    saveToKeychain(key: "token", value: token)
}


//  Save id to keychain
func saveIdKeychain(id : String) {
    saveToKeychain(key: "id", value: id)
}




func getFromKeychain(key : String) -> String? {
    
    let query: [String: Any] = [
        kSecClass as String : kSecClassGenericPassword,
        kSecAttrService as String : serviceName,
        kSecAttrAccount as String : key,
        kSecReturnData as String : kCFBooleanTrue!,
        kSecMatchLimit as String : kSecMatchLimitOne
        ]
    
    var dataTypeRef : AnyObject?
    
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    
    if status == errSecSuccess, let retrievedData = dataTypeRef as? Data {
        return String(data: retrievedData, encoding: .utf8)
    }else{
        print("\(key) bulunamadı. error: \(status)")
        return nil
    }
}



func clearKeychain() {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: serviceName
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    
    if status == errSecSuccess {
        print("Keychain başarıyla temizlendi.")
    } else {
        print("Keychain temizleme hatası: \(status)")
    }
}


