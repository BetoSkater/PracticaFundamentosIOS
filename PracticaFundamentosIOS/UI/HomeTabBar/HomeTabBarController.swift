//
//  HomeTabBarController.swift
//  PracticaFundamentosIOS
//
//  Created by Alberto Junquera Ramírez on 2/1/23.
//

import UIKit

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpLayout()
        setUpTabs()
        
    }
    
    private func setUpTabs(){
        let firstNavigationController = UINavigationController(rootViewController: TableViewController())
        let tableImage = UIImage(systemName: SystemEnum.listIcon.rawValue)
        firstNavigationController.tabBarItem = UITabBarItem(title: TextEnum.characterTable.rawValue, image: tableImage, tag: 0)
        //firstNavigationController.navigationBar.tintColor = UIColor(named: SystemEnum.gokuBlue.rawValue)
        
        let secondNavigationController = UINavigationController(rootViewController: CollectionViewController())
        let collectionImage = UIImage(systemName: SystemEnum.collectionIcon.rawValue)
        secondNavigationController.tabBarItem = UITabBarItem(title: TextEnum.charactersCollection.rawValue, image: collectionImage, tag: 1)
        
        let thirdNavigationController = UINavigationController(rootViewController: SettingsViewController())
        let settingsImage = UIImage(systemName: SystemEnum.settingsGear.rawValue)
        thirdNavigationController.tabBarItem = UITabBarItem(title: TextEnum.settings.rawValue, image: settingsImage, tag: 2)
        
        viewControllers = [firstNavigationController,secondNavigationController,
        thirdNavigationController]
    }
    
    private func setUpLayout(){
        tabBar.barTintColor = .systemOrange
        tabBar.tintColor = UIColor(named: SystemEnum.gokuBlue.rawValue)
         
    }

    
}
