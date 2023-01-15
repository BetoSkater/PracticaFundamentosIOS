//
//  SettingsViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 15/1/23.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logOutButton.layer.cornerRadius = 10
    }
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        logOut()
    }
}
