//
//  CatalogueCoordinator.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class CatalogueCoordinator: Coordinator {
    let presenter: UINavigationController
    let catalogueDataManager: CatalogueDataManager
    
    init(presenter: UINavigationController, catalogueDataManager: CatalogueDataManager) {
        self.presenter = presenter
        self.catalogueDataManager = catalogueDataManager
    }
    
    override func start() {
        let catalogueViewModel = CatalogueViewModel(catalogueDataManager: self.catalogueDataManager)
        let catalogueViewController = CatalogueViewController(viewModel: catalogueViewModel)
        catalogueViewModel.viewDelegate = catalogueViewController
        catalogueViewModel.coordinateDelegate = self
        presenter.pushViewController(catalogueViewController, animated: false)
    }
    
    override func finish() {
        
    }
}

extension CatalogueCoordinator: CatalogueCoordinatorDelegate {
    func didSelect(imageData: Data) {
        let imageDetailViewModel = ImageDetailViewModel(imageData: imageData)
        let imageDetailViewController = ImageDetailViewController(viewModel: imageDetailViewModel)
        imageDetailViewModel.viewDelegate = imageDetailViewController
        imageDetailViewModel.coordinateDelegate = self
        presenter.pushViewController(imageDetailViewController, animated: false)
    }
    
    
}

extension CatalogueCoordinator: ImageDetailCoordinatorDelegate {
    
}
