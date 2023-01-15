//
//  CollectionViewController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 4/1/23.
//

import UIKit

class CollectionViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var favHeroList:[Heroe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = TextEnum.favouriteHeroes.rawValue
        
        let xib = UINib(nibName: SystemEnum.collectionViewCell.rawValue, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: SystemEnum.characterCollectionCell.rawValue)
        
        let token = LocalDataLayer.shared.getToken()
        //TODO: Call the function to retrive the favedHeroes
        retrieveFavedHeroes(token: token)
    }

     func retrieveFavedHeroes(token: String)->(){
        NetworkLayer.shared.retrieveHeroes(token: token) { [weak self] listOfHeroes, error in
            
            if let listOfHeroes = listOfHeroes{
                //TODO: try to fix the unwrap of self. I do not understant it quite well yet.
                self!.favHeroList = listOfHeroes.filter {$0.favorite == true}
               
                //TODO: Check that this work
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    

}
//MARK: - CollectionView Delegate and Data Source Methods -
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favHeroList?.count ?? -1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SystemEnum.characterCollectionCell.rawValue, for: indexPath) as! CollectionViewCell

        if let favedHeroes = favHeroList{
            let favHero = favedHeroes[indexPath.row]
            cell.collectionImageView.setImage(url: favHero.photo)
            cell.collectionLabel.text = favHero.name
        }
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
        detailsView.delegate = self
        detailsView.dataToShow = .hero
        detailsView.heroe = favHeroList?[indexPath.row]
        navigationController?.pushViewController(detailsView, animated: true)
    }
}

//MARK: - Image Extension in CollectionView -

//MARK: - Extension to conform the protocol HeroUpdaterDelegate -

extension CollectionViewController: HeroUpdaterDelegate{
    func heroWasModified(updated heroe: Heroe) {
       print("print at collectionView func hero was modified")
        if var theFavHeroList = self.favHeroList{
            let heroeIndex = theFavHeroList.firstIndex{ $0.id == heroe.id} ?? -1
            theFavHeroList[heroeIndex].favorite = heroe.favorite
            self.favHeroList = theFavHeroList
            DispatchQueue.main.async {
                print("dispatch queue inside the overrided delegate func at tableviewcontroller")
                self.collectionView.reloadData()
            }
            self.collectionView.reloadData()
            //TODO: find out which of the reloadData is the one working
        }
    }
    
    
}
