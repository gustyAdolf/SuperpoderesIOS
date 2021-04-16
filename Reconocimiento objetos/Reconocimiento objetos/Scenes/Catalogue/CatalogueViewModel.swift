//
//  CatalogueViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Foundation

protocol CatalogueCoordinatorDelegate: class {
    func didSelect(imageData: Data)
}

protocol CatalogueViewDelegate: class {
    func imagesLoaded()
}

class CatalogueViewModel {
    weak var coordinateDelegate: CatalogueCoordinatorDelegate?
    weak var viewDelegate: CatalogueViewDelegate?
    var catalogueCellViewModels: [CatalogueCellViewModel] = []
    let catalogueDataManager: CatalogueDataManager
    
    init(catalogueDataManager: CatalogueDataManager) {
        self.catalogueDataManager = catalogueDataManager
    }
    
    
    private func fetchListOfImages() {
        self.catalogueDataManager.fetchListOfImages(amountOfImages: 100) { [weak self] result in
            switch result {
                case .success(let response):
                    guard let listOfImages = response else {return}
                    self?.catalogueCellViewModels = listOfImages.map({
                        CatalogueCellViewModel(imageURL: $0.downloadURL ?? "", catalogueDataManager: self?.catalogueDataManager)
                    })
                    self?.viewDelegate?.imagesLoaded()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func viewWasLoaded() {
        fetchListOfImages()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return catalogueCellViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CatalogueCellViewModel? {
        guard indexPath.row < catalogueCellViewModels.count else {return nil}
        return catalogueCellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let imageData = catalogueCellViewModels[indexPath.row].imageData else {return}
        coordinateDelegate?.didSelect(imageData: imageData)
    }
}
