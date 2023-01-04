//
//  LoginViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        //-TODO: Esto iria dentro del async de DispathQueue
        
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow}
            .first?
            .rootViewController = HomeTabBarController()
    }
    
   
}
