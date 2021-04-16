//
//  CatalogueCell.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class CatalogueCell: UICollectionViewCell {
    
    var viewModel: CatalogueCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            viewModel.viewDelegate = self
            imageView.image = UIImage(named: viewModel.imageName)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 156, height: 204)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 156),
            imageView.heightAnchor.constraint(equalToConstant: 204),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension CatalogueCell: CatalogueCellViewDelegate {
    
}
