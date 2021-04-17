//
//  TitleScreenCoordinator.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import UIKit

class TitleScreenCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController){
        self.presenter = presenter
    }
    
    override func start() {
        let titleScreenViewModel = TitleScreenViewModel()
        let titleScreenViewController = TitleScreenViewController(viewModel: titleScreenViewModel)
        titleScreenViewModel.coordinateDelegate = self
        // TODO view delegate and coordinator delegate
        presenter.pushViewController(titleScreenViewController, animated: false)
    }
    
    override func finish() {
        // TODO
    }
}

extension TitleScreenCoordinator: TitleScreenCoordinatorDelegate {
    func startGameTapped() {
        let gameViewModel = GameViewModel()
        let gameViewController = GameViewController(viewModel: gameViewModel)
        gameViewController
        gameViewModel.coordinateDelegate = self
        gameViewModel.viewDelegate = gameViewController
        presenter.pushViewController(gameViewController, animated: true)
    }
    
}

extension TitleScreenCoordinator: GameCoordinatorDelegate {
    func exitButtonTapped() {
        presenter.popViewController(animated: true)
    }
    
    
}
