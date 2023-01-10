//
//  TableViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit
//TODO: aqui seria una herencia de BaseViewController
class TableViewController: BaseViewController {
    enum DataList{
        case AllHeroes
        case HeroTransformations
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    //Variable that get the value that indicates which list to load.
        
    var dataToShow = DataList.AllHeroes
    
    var heroesList: [Heroe]?
    var transformationList: [Transformation]?
    
    
    
    //TODO: complete the transformation list stage
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: SystemEnum.tableViewCell.rawValue, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: SystemEnum.characterCell.rawValue)
        
        let token = LocalDataLayer.shared.getToken()

        
        
        switch dataToShow{
        case .AllHeroes:
            NetworkLayer.shared.retrieveHeroes(token: token) { [weak self] allHeroes, error in
                guard let self = self else{return} //
                
                if let allHeroes = allHeroes{
                    self.heroesList = allHeroes
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                   
                }else{
                    print("Error fetching the heroes list: ", error?.localizedDescription  ?? "")
                }
            }
        case .HeroTransformations:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        default: print("Error: not such a type list avaiable")
        
        }
    }

}
//MARK: - UITableViewDelegate and UITableViewDataSource extension.-
extension TableViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataToShow{
            case .AllHeroes: return heroesList?.count ?? -1
        case .HeroTransformations: return transformationList?.count ?? -1
            default: return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SystemEnum.characterCell.rawValue, for: indexPath) as! TableViewCell
        
        switch dataToShow{
            case .AllHeroes:
            
            if let listedHeroes = heroesList {
                let heroe = listedHeroes[indexPath.row]
                //TODO: fix image
                cell.pictureImageView.setImage(url: heroe.photo)
                cell.titleLabel.text = heroe.name
                cell.descriptionLabel.text = heroe.description
                
            }
                
            case .HeroTransformations:
            if let transformList = transformationList{
                let transform = transformList[indexPath.row]
                
                cell.pictureImageView.setImage(url: transform.photo)
                cell.titleLabel.text = transform.name
                cell.descriptionLabel.text = transform.description
                
            }
                
            default:
            //TODO: test if there is a way to execute this default
                cell.pictureImageView.image = UIImage(imageLiteralResourceName: "fondo4")
                cell.titleLabel.text = "Prueba Titulo"
                cell.descriptionLabel.text = "Prueba descripcion"
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = DetailsViewController()
        
        switch dataToShow{
            case .AllHeroes:
            if let heroeDetail = heroesList?[indexPath.row]{
                detailsView.dataToShow = .hero
                detailsView.heroe = heroeDetail
                navigationController?.pushViewController(detailsView, animated: true)
            }

            case .HeroTransformations:
            if let transformDetail = transformationList?[indexPath.row]{
                detailsView.dataToShow = .transformation
                detailsView.transformation = transformDetail
                navigationController?.pushViewController(detailsView, animated: true)
            }
            
            default:
            navigationController?.pushViewController(detailsView, animated: true)
        }
        
        
        
    }
}

extension UIImageView{
    private func downloadImage(url: URL, completion: @escaping (UIImage?) -> ()){
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
    
    func setImage(url: String){
        guard let url = URL(string: url) else {return}
        
        downloadImage(url: url) { [weak self] image in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

