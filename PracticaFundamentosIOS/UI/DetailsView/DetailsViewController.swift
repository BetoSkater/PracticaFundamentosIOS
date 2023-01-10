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
    var transformation: Transformation?
    var heroTransformationsList:[Transformation]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = LocalDataLayer.shared.getToken()
        transformationButton.isHidden = true
        if let detailType = dataToShow{
            
            switch detailType{
            case .hero:
                //TODO: Should I unwrap the optional with an if let?
                //In theory, if we get here with the enum, it should have data in everycase unless sone field is empty
                detailsImageView.setImage(url: heroe?.photo ?? "")
                detailsNameLabel.text = heroe?.name ?? "...**"
                detailsDescLabel.text = heroe?.description ?? "...***"
                
                //TODO: modify button just in case.
                loadHeroTransformations(token: token , heroId: heroe?.id ?? MiscValues.emptyValue.rawValue)
                
                
            case .transformation: detailsImageView.setImage(url: transformation?.photo ?? "")
                detailsNameLabel.text = transformation?.name ?? "...**"
                detailsDescLabel.text = transformation?.description ?? "...***"
                
                transformationButton.isHidden = true
                
            default: break
            }
        }
        
    }


   
    @IBAction func transformationButtonTapped(_ sender: UIButton) {
        let transformationView = TableViewController()
        if let dataType = dataToShow{
            switch dataType{
            case .hero:
                if let transformationList = heroTransformationsList{
                    transformationView.dataToShow = .HeroTransformations
                    transformationView.transformationList = transformationList
                    navigationController?.pushViewController(transformationView, animated: true)
                }
            case .transformation: break
            default: break
            }
        }
        
        
    }
    
    func loadHeroTransformations(token: String?,heroId: String?)->(){
        
        NetworkLayer.shared.retrieveTransformations(token: token, heroId: heroId) { [weak self] transformations, error in
            guard let self = self else {return}
            
            if let transformations = transformations{
                self.heroTransformationsList = transformations
                
                if !transformations.isEmpty{
                    DispatchQueue.main.async {
                        self.transformationButton.isHidden = false
                            print("---->>TRANSFORMATION COUNT = \(transformations.count)")
                        }
                }else{
                    print("---->> \(self.heroe?.name ?? "char") doesn't have transformations")
                }
                    
                
            }else{
                print("Error retrieven transformations: ",  error?.localizedDescription ?? MiscValues.emptyValue.rawValue)
            }
        }
        
    }
}
