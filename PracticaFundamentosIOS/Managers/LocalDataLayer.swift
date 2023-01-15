//
//  LocalDataLayer.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 5/1/23.
//

import Foundation

final class LocalDataLayer{
    
    
    private static let token = "token"
    private static let heroes = "heroes"
    //Singleton
    static let shared = LocalDataLayer()
    
    //MARK: - TOKEN -
    
    
    func save(token: String){
        return UserDefaults.standard.set(token, forKey: Self.token)
    }
    
    func getToken() -> String{
        return UserDefaults.standard.string(forKey: Self.token) ?? ""
    }
    
    func deleteToken() -> (){
        UserDefaults.standard.removeObject(forKey: Self.token) 
    }
    
    //MARK: - User login related data. -
    
    func isUserLogged() -> Bool {
        return !getToken().isEmpty
    }
    
    
}
