//
//  CollectionViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 4/1/23.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: SystemEnum.collectionViewCell.rawValue, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: SystemEnum.characterCollectionCell.rawValue)
        
    }


    

}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SystemEnum.characterCollectionCell.rawValue, for: indexPath) as! CollectionViewCell
        
       // cell.collectionImageView.image = UIImage(named: "title")
        cell.collectionImageView.image = UIImage(systemName: SystemEnum.sevenDragonBalls.rawValue)
        cell.collectionLabel.text = "Prueba nombre"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing
        let finalWidth = (collectionView.frame.width - totalSpacing) / itemsInRow
        
        return CGSize(width: finalWidth, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailsView = DetailsViewController()
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
