//
//  SearchCoordinator.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class SearchCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let searchViewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewModel.viewDelegate = searchViewController
        searchViewModel.coordinateDelegate = self
        presenter.pushViewController(searchViewController, animated: false)
    }
}

extension SearchCoordinator: SearchCoordinatorDelegate {
    
}
