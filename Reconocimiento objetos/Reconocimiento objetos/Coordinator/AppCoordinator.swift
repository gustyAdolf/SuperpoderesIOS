//
//  AppCoordinator.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class AppCoordinator: Coordinator {

    let sessionAPI = SessionAPI()
    
    lazy var dataManager: ClientDataManager = {
        let dataManager = ClientDataManager(remoteDataManager: RemoteDataManagerIml(session: sessionAPI))
        return dataManager
    }()
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let tabBarController = UITabBarController()
        
        let catalogueNavController = UINavigationController()
        let catalogueCoordinator = CatalogueCoordinator(presenter: catalogueNavController,catalogueDataManager: dataManager)
        addChildCoordinator(catalogueCoordinator)
        catalogueCoordinator.start()
        
        let searchNavController = UINavigationController()
        let searchCoordinator = SearchCoordinator(presenter: searchNavController)
        addChildCoordinator(searchCoordinator)
        searchCoordinator.start()
        
        tabBarController.viewControllers = [catalogueNavController, searchNavController]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: "square.grid.2x2.fill")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "magnifyingglass")
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        
    }
}
