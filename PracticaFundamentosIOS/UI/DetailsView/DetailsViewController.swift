//
//  DetailsViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsDescLabel: UILabel!
    @IBOutlet weak var transformationButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    enum DataList{
        case hero
        case transformation
    }
    
    var dataToShow: DataList?
    var heroe : Heroe?
    var transformation: Transformation?
    var heroTransformationsList:[Transformation]?
    let token = LocalDataLayer.shared.getToken()
    var delegate: HeroUpdaterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformationButton.isHidden = true
        transformationButton.layer.cornerRadius = 10
        
        if let detailType = dataToShow{
            switch detailType{
            case .hero:
                //TODO: Should I unwrap the optional with an if let?
                //In theory, if we get here with the enum, it should have data in everycase unless some field is empty
                detailsImageView.setImage(url: heroe?.photo ?? "")
                detailsNameLabel.text = heroe?.name ?? ""
                detailsDescLabel.text = heroe?.description ?? ""
                if heroe?.favorite ?? false{
                    favButton.setImage(UIImage(systemName: SystemEnum.starFill.rawValue), for: .normal)
                }
                //TODO: modify button just in case.
                loadHeroTransformations(token: token , heroId: heroe?.id ?? MiscValues.emptyValue.rawValue)
                
            case .transformation: detailsImageView.setImage(url: transformation?.photo ?? "")
                detailsNameLabel.text = transformation?.name ?? ""
                detailsDescLabel.text = transformation?.description ?? ""
                
                transformationButton.isHidden = true
                favButton.isHidden = true
            }
        }
    }
    //MARK: - Buttons Actions -
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
            }
        }
    }
    
    @IBAction func favButtonTapped(_ sender: UIButton) {
        //TODO: add favourite functionality here in the button
        //Note: as the button is hidden in the viewDidLoad in case de dataToShow is a transformation, I think that I do not have to do it here too.
        
        if let heroe = heroe{
            favUnfav(token: token, and: heroe)
        }
    }
    //MARK: -Class Methods-
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
    
    func favUnfav(token: String, and heroe: Heroe)->(){
        var updatedHeroe = heroe
        NetworkLayer.shared.setFavourite(token: token, heroId: heroe.id) { response, error in
            if let response = response{
                
                print("\(response.statusCode)   in detailsView")
                
                DispatchQueue.main.async {
                    print("Inside DispatchQueue")
                    if heroe.favorite{
                        self.favButton.setImage(UIImage(systemName: SystemEnum.star.rawValue), for: .normal)
                        updatedHeroe.favorite = !heroe.favorite
                        print("unliked")
                    }else{
                        self.favButton.setImage(UIImage(systemName: SystemEnum.starFill.rawValue), for: .normal)
                        updatedHeroe.favorite = !heroe.favorite
                        print("liked")
                    }//else
                    if self.delegate != nil{
                        self.delegate?.heroWasModified(updated: updatedHeroe)
                    }
                }//DispatchQueue
            }
        }//Network
        // return updatedHeroe
    }//func favunfav
}
//MARK: - Protocol HeroUpdaterDelegate -
protocol HeroUpdaterDelegate{
    func heroWasModified(updated heroe: Heroe)
}
