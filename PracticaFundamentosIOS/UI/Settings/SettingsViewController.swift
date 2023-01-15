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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
