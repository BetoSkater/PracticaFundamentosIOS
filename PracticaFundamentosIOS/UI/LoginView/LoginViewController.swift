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
        
        loginButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty else{
            print("Error: email field is empty.")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else{
            print("Error: password field is empty")
            return
        }
        
        NetworkLayer.shared.login(email: email, password: password) { token, error in
            if let token = token{
                LocalDataLayer.shared.save(token: token)
                print("Valid token saved.")
                
                DispatchQueue.main.async {
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap { ($0 as? UIWindowScene)?.keyWindow}
                        .first?
                        .rootViewController = HomeTabBarController()
                }
            }else{
                print("Login Error:", error?.localizedDescription ?? "")
            }
        }
    }
}
