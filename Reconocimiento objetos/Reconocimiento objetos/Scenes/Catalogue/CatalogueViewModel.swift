//
//  CatalogueViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Foundation

protocol CatalogueCoordinatorDelegate: class {
    func didSelect(imageNamed: String)
}

protocol CatalogueViewDelegate: class {
    func imagesLoaded()
}

class CatalogueViewModel {
    weak var coordinateDelegate: CatalogueCoordinatorDelegate?
    weak var viewDelegate: CatalogueViewDelegate?
    var catalogueCellViewModels: [CatalogueCellViewModel] = []
    
    
    func viewWasLoaded() {
        for index in 17 ..< 119 {
            catalogueCellViewModels.append(CatalogueCellViewModel(imageName: String(format: "testImage_%i", index)))
        }
        viewDelegate?.imagesLoaded()
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
        coordinateDelegate?.didSelect(imageNamed: catalogueCellViewModels[indexPath.row].imageName)
    }
}
