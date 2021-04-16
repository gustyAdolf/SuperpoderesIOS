//
//  CatalogueViewController.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class CatalogueViewController: UIViewController {

    let viewModel: CatalogueViewModel
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flowLayout.minimumInteritemSpacing = 42
        flowLayout.itemSize = CGSize(width: 156, height: 204)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumLineSpacing = 52
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CatalogueCell.self, forCellWithReuseIdentifier: "CatalogueCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(viewModel: CatalogueViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension CatalogueViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let catalogueCellViewModel = viewModel.viewModel(at: indexPath),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatalogueCell", for: indexPath) as? CatalogueCell else {fatalError()}
        cell.viewModel = catalogueCellViewModel
        return cell
    }
    
    
}

extension CatalogueViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension CatalogueViewController: CatalogueViewDelegate {
    func imagesLoaded() {
        collectionView.reloadData()
    }
    
    
}
