//
//  SearchViewController.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit

class SearchViewController: UIViewController {

    let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

extension SearchViewController: SearchViewDelegate {
    
}
