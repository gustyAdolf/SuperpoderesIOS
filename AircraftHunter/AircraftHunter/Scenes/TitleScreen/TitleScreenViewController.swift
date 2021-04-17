//
//  TitleScreenViewController.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import UIKit

class TitleScreenViewController: UIViewController {

    let viewModel: TitleScreenViewModel
    
    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "title_img")
        backgroundImage.contentMode = .scaleAspectFit
        return backgroundImage
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .titleGame
        titleLabel.text = "Aircraft HUNTER"
        return titleLabel
    }()
    
    lazy var startGameButton: UIButton = {
        let startGameButton = UIButton()
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        startGameButton.setTitle("Start game", for: .normal)
        startGameButton.titleLabel?.font = .startGame
        startGameButton.addTarget(self, action: #selector(startGameTapped), for: .touchUpInside)
        return startGameButton
    }()
    
    lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = .hightScore
        scoreLabel.text = "Hight score: \(viewModel.lastScore)"
        return scoreLabel
    }()
    
    init(viewModel: TitleScreenViewModel) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateScore()
        scoreLabel.text = "Hight score: \(viewModel.lastScore)"
    }
    
    @objc func startGameTapped() {
        viewModel.startGameTapped()
    }
    
    private func setupConstraints() {
        
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        ])
        
        view.addSubview(startGameButton)
        NSLayoutConstraint.activate([
            startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -62)
        ])
        
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    
}
