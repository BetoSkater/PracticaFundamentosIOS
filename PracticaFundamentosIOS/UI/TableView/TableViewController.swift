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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: SystemEnum.tableViewCell.rawValue, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: SystemEnum.characterCell.rawValue)
        
        let token = LocalDataLayer.shared.getToken()
        
        switch dataToShow{
        case .AllHeroes:
            navigationItem.title = TextEnum.characterTable.rawValue
            
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
            navigationItem.title = TextEnum.transformations.rawValue
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
//MARK: - UITableViewDelegate and UITableViewDataSource extension.-
extension TableViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataToShow{
        case .AllHeroes: return heroesList?.count ?? -1
        case .HeroTransformations: return transformationList?.count ?? -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SystemEnum.characterCell.rawValue, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        
        switch dataToShow{
        case .AllHeroes:
            if let listedHeroes = heroesList {
                let heroe = listedHeroes[indexPath.row]
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = DetailsViewController()
        
        switch dataToShow{
        case .AllHeroes:
            if let heroeDetail = heroesList?[indexPath.row]{
                detailsView.dataToShow = .hero
                detailsView.heroe = heroeDetail
                detailsView.delegate = self
                navigationController?.pushViewController(detailsView, animated: true)
            }
        case .HeroTransformations:
            if let transformDetail = transformationList?[indexPath.row]{
                detailsView.dataToShow = .transformation
                detailsView.transformation = transformDetail
                navigationController?.pushViewController(detailsView, animated: true)
            }
        }
    }
}
//MARK: - UIImageView extension -
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
//MARK: - HeroUpdaterDelegate methods -
extension TableViewController: HeroUpdaterDelegate{
    func heroWasModified(updated heroe: Heroe) {
        print("print at tableviewController func hero was modified")
        if var theHeroList = self.heroesList{
            let heroeIndex = theHeroList.firstIndex{ $0.id == heroe.id} ?? -1
            theHeroList[heroeIndex].favorite = heroe.favorite
            self.heroesList = theHeroList
            DispatchQueue.main.async {
                print("dispatch queue inside the overrided delegate func at tableviewcontroller")
                self.tableView.reloadData()
            }
            //self.tableView.reloadData()
        }
    }
}
