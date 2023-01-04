//
//  TableViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit
//TODO: aqui seria una herencia de BaseViewController
class TableViewController: BaseViewController {
      
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let xib = UINib(nibName: SystemEnum.tableViewCell.rawValue, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: SystemEnum.characterCell.rawValue)
    }

}
//MARK: - UITableViewDelegate and UITableViewDataSource extension.-
extension TableViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SystemEnum.characterCell.rawValue, for: indexPath) as! TableViewCell
        
        cell.pictureImageView.image = UIImage(imageLiteralResourceName: "fondo4")
        cell.titleLabel.text = "Prueba Titulo"
        cell.descriptionLabel.text = "Prueba descripcion"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 386
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsView = DetailsViewController()
        navigationController?.pushViewController(detailsView, animated: true)
    }
}

