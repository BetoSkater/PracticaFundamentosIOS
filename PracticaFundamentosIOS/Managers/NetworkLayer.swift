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
    case setFav = "/api/data/herolike"
}
enum ApiMethod:String{
    case get = "GET"
    case post = "POST"
}

enum MiscValues:String{
    case authorization = "Authorization"
    case basic = "Basic"
    case name = "name"
    case emptyValue = ""
    case bearer = "Bearer "
    case id = "id"
    case hero = "hero"
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
        
        //Task
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
    
    //MARK: - Heroes Call -
    
    func retrieveHeroes(token: String?, completion: @escaping([Heroe]?, Error?)->()){
        //URL generation:
        
        guard let url = URL(string: EndPoint.baseURL.rawValue + EndPoint.heroesList.rawValue) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        //Query to retrieve all heroes. Check postman
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: MiscValues.name.rawValue,
                                                 value: MiscValues.emptyValue.rawValue)]
        
        //Acess Method:
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = ApiMethod.post.rawValue
        urlRequest.setValue(MiscValues.bearer.rawValue + (token ?? MiscValues.emptyValue.rawValue), forHTTPHeaderField: MiscValues.authorization.rawValue)
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        //Petition:
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else{
                completion(nil, error)
                return
            }
            
            guard let data = data else{
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let heroes = try? JSONDecoder().decode([Heroe].self, from: data) else{
                completion(nil, NetworkError.decodingFailed)
                return
            }
            completion(heroes, nil)
        }
        task.resume()
    }
    
    //MARK: - TRANSFORMATION CALLS -
    
    func retrieveTransformations(token: String?, heroId: String?, completion: @escaping ([Transformation]?, Error?) -> ()){
        //Url generation:
        guard let url = URL(string: EndPoint.baseURL.rawValue + EndPoint.transformationsList.rawValue) else{
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        //Query to retrieve all transformations from a hero.
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: MiscValues.id.rawValue, value: heroId ?? MiscValues.emptyValue.rawValue )]
        
        //Access Method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = ApiMethod.post.rawValue
        urlRequest.setValue(MiscValues.bearer.rawValue + (token ?? MiscValues.emptyValue.rawValue), forHTTPHeaderField: MiscValues.authorization.rawValue)
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        //Task:
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else{
                completion(nil, error)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                print("Error loading the url:", (response as? HTTPURLResponse)?.statusCode ?? -1)
                return
            }
            
            guard let data = data else{
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let transformations = try? JSONDecoder().decode([Transformation].self, from: data) else{
                completion(nil, NetworkError.decodingFailed)
                return
            }
            completion(transformations, nil)
        }
        task.resume()
    }
    
    //MARK: - FAVOURITE CALLS -
    
    func setFavourite(token: String?, heroId: String?, completion: @escaping (HTTPURLResponse?, Error?)->() ){
        
        //URL generation:
        guard let url = URL(string: EndPoint.baseURL.rawValue + EndPoint.setFav.rawValue) else {
            completion(nil, NetworkError.malformedURL)
            return
        }
        
        //Query to a Hero
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: MiscValues.hero.rawValue, value: heroId ?? MiscValues.emptyValue.rawValue)]
        
        //AccessPetition
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = ApiMethod.post.rawValue
        urlRequest.setValue(MiscValues.bearer.rawValue + (token ?? MiscValues.emptyValue.rawValue), forHTTPHeaderField: MiscValues.authorization.rawValue)
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        //Task:
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            //When doing the like call in postmant, the good response is the 201
            guard (response as? HTTPURLResponse)?.statusCode == 201 else{
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(nil, NetworkError.statusCode(code: statusCode))
                print("\(String(describing: (response as? HTTPURLResponse)?.statusCode))  In network layer")
                return
            }
            guard let data = data else{
                completion(nil, NetworkError.noData)
                //doing expression data while debbuging yields a "$R5 = 0 bytes" note: $R5 has this name because is the fifth expression that I have evaluated.
                return
            }
            completion((response as? HTTPURLResponse),nil)
        }
        task.resume()
    }
}
