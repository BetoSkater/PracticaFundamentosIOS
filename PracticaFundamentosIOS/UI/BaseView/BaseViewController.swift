//
//  BaseViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func logOut(){
        //Remove the token from UserDefaults
        LocalDataLayer.shared.deleteToken()
        
        UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow}
                    .first?
                    .rootViewController = LoginViewController()
    }
    

}
