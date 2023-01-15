//
//  Tools.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 14/1/23.
//

//import Foundation
import UIKit

class Tools{
    
}

protocol UrlImageManagement{
    
}

extension UrlImageManagement{
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> ()){
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else{
                completion(nil)
                print("Error at fetching the image.")
                return
            }
            guard let data = data, let image = UIImage(data: data)else{
                completion(nil)
                print("Error at generating the image.")
                return
            }
            completion(image)
        }
        task.resume()
    }
    /*
    func setImage(url: String){
        guard let url = URL(string: url) else {return}
        
        downloadImage(url: url) { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
     */
}
 
