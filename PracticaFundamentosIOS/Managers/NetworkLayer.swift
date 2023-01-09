//
//  NetworkLayer.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 9/1/23.
//

import Foundation

enum NetworkError: Error{
   case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

enum EndPoint:String{
    case baseURL = "https://dragonball.keepcoding.education"
    case login = "/api/auth/login"
    case heroesList = "/api/heros/all"
    case transformationsList = "/api/heros/tranformations"
}
enum ApiMethod:String{
    case get = "GET"
    case post = "POST"
}

enum MiscValues:String{
    case authorization = "Authorization"
    case basic = "Basic"
}

final class NetworkLayer{
    
    static let shared = NetworkLayer()
    
    //MARK: -Login: -
    
    
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> ()){
        //URL generation
        guard let url = URL(string: EndPoint.baseURL.rawValue + EndPoint.login.rawValue) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
          
        //email-passwoed encoding:
        let loginString = "\(email):\(password)"
        let loginData: Data = loginString.data(using: .utf8)!
        let base64 = loginData.base64EncodedString()
        
        //Access mode:
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = ApiMethod.post.rawValue
        urlRequest.setValue("\(MiscValues.basic.rawValue) \(base64)", forHTTPHeaderField: MiscValues.authorization.rawValue)
        
        //Api Call
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else{
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else{
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                return
            }
            
            guard let token = String(data: data, encoding: .utf8) else{
                completion(nil, NetworkError.decodingFailed)
                return
            }
            
            completion(token, nil)
        }
        task.resume()
    }
    
    
    
}
