//
//  DetailsViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class DetailsViewController: UIViewController {
    //TODO: Add an scrollview at least in the description. It would be better to add it to the whole view.
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsDescLabel: UILabel!
    @IBOutlet weak var transformationButton: UIButton!
    
    //TODO: Extract enum as it is the same as the one in TableView
    //Ok is not the same, but is similar, it all can go in the same enum.
    enum DataList{
        case hero
        case transformation
    }
    
    //TODO: Add the transformation item
    var dataToShow: DataList?
    var heroe : Heroe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detailType = dataToShow{
            switch detailType{
            case .hero:
                //TODO: Should I unwrap the optional with an if let?
                //In theory, if we get here with the enum, it should have data in everycase unless sone field is empty
                detailsImageView.setImage(url: heroe?.photo ?? "")
                detailsNameLabel.text = heroe?.name ?? "...**"
                detailsDescLabel.text = heroe?.description ?? "...***"
                
                //TODO: modify button just in case.
                
                
                
            case .transformation: break
            default: break
            }
        }
        
    }


   
    @IBAction func transformationButtonTapped(_ sender: UIButton) {
        let tranformationView = TableViewController()
        navigationController?.pushViewController(tranformationView, animated: true)
    }
}
