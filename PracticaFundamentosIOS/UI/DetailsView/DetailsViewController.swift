//
//  DetailsViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class DetailsViewController: UIViewController {

    
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    
    @IBOutlet weak var detailsNameLabel: UILabel!
    
    
    @IBOutlet weak var detailsDescLabel: UILabel!
    
    
    
    @IBOutlet weak var transformationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    @IBAction func transformationButtonTapped(_ sender: UIButton) {
        let tranformationView = TableViewController()
        navigationController?.pushViewController(tranformationView, animated: true)
    }
}
