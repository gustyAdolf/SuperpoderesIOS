//
//  AppCoordinator.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        if (UserDefaults.standard.integer(forKey: "score") == 0) {
            UserDefaults.standard.set(0, forKey: "score")
        }
        let titleScreenNavController = UINavigationController()
        titleScreenNavController.setNavigationBarHidden(true, animated: false)
        let titleScreenCoordinator = TitleScreenCoordinator(presenter: titleScreenNavController)
        addChildCoordinator(titleScreenCoordinator)
        titleScreenCoordinator.start()
        
        window.rootViewController = titleScreenNavController
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        // TODO
    }
}
