//
//  CatalogueCoordinator.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class CatalogueCoordinator: Coordinator {
    let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    override func start() {
        let catalogueViewModel = CatalogueViewModel()
        let catalogueViewController = CatalogueViewController(viewModel: catalogueViewModel)
        catalogueViewModel.viewDelegate = catalogueViewController
        catalogueViewModel.coordinateDelegate = self
        presenter.pushViewController(catalogueViewController, animated: false)
    }
    
    override func finish() {
        
    }
}

extension CatalogueCoordinator: CatalogueCoordinatorDelegate {
    func didSelect(imageNamed: String) {
        let imageDetailViewModel = ImageDetailViewModel(imageNamed: imageNamed)
        let imageDetailViewController = ImageDetailViewController(viewModel: imageDetailViewModel)
        imageDetailViewModel.viewDelegate = imageDetailViewController
        imageDetailViewModel.coordinateDelegate = self
        presenter.pushViewController(imageDetailViewController, animated: false)
    }
    
    
}

extension CatalogueCoordinator: ImageDetailCoordinatorDelegate {
    
}
