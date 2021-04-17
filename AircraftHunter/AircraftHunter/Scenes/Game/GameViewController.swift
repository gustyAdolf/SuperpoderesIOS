//
//  GameViewController.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import UIKit
import ARKit
import SceneKit

class GameViewController: UIViewController {
    
    let viewModel: GameViewModel
    
    lazy var sceneView: ARSCNView = {
        let sceneView = ARSCNView()
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.contentMode = .scaleToFill
        sceneView.loops = true
        sceneView.session.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        return sceneView
    }()
    
    lazy var shootButton: UIButton = {
        let shootButton = UIButton()
        shootButton.frame.size =  CGSize(width: 81, height: 81)
        shootButton.layer.cornerRadius = shootButton.frame.height/2
        shootButton.backgroundColor = .black
        shootButton.translatesAutoresizingMaskIntoConstraints = false
        shootButton.setTitle("SHOOT", for: .normal)
        shootButton.addTarget(self, action: #selector(shootInfiniteBullet), for: .touchUpInside)
        return shootButton
    }()
    
    lazy var aimImage: UIImageView = {
        let aimImage = UIImageView()
        aimImage.translatesAutoresizingMaskIntoConstraints = false
        aimImage.image = UIImage(named: "aim")
        aimImage.contentMode = .scaleAspectFit
        return aimImage
    }()
    
    lazy var exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle("Exit", for: .normal)
        exitButton.layer.cornerRadius = 8
        exitButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        exitButton.backgroundColor = UIColor(red: 253.0 / 255.0, green: 82.0 / 255.0, blue: 82.0 / 255.0, alpha: 1.0)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return exitButton
    }()
    
    
    lazy var scoreLabel: UIButton = {
        let scoreLabel = UIButton()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.setTitle("Score: \(viewModel.currentScore)", for: .normal)
        scoreLabel.layer.cornerRadius = 8
        scoreLabel.layer.maskedCorners = [.layerMinXMaxYCorner]
        scoreLabel.backgroundColor = UIColor(red: 120.0 / 255.0, green: 117.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
        return scoreLabel
    }()
    
    var planes = [Plane]()
    
    init(viewModel: GameViewModel) {
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
        setupComponents()
    }
    
    private func movePlanes() {
        guard let camera = self.sceneView.session.currentFrame?.camera else { return }
        planes.forEach {
            $0.move(camera)
        }
    }
    
    
    private func setupComponents() {
        guard ARWorldTrackingConfiguration.isSupported else { return }
        startTracking()
        addNewPlane()
        movePlanes()
    }
    
    private func setupConstraints() {
        
        view.addSubview(sceneView)
        NSLayoutConstraint.activate([
            sceneView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sceneView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sceneView.widthAnchor.constraint(equalTo: view.widthAnchor),
            sceneView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        view.addSubview(aimImage)
        NSLayoutConstraint.activate([
            aimImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aimImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(shootButton)
        NSLayoutConstraint.activate([
            shootButton.widthAnchor.constraint(equalToConstant: 81),
            shootButton.heightAnchor.constraint(equalToConstant: 81),
            shootButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 96),
            shootButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ])
        
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 187),
            exitButton.heightAnchor.constraint(equalToConstant: 48),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.widthAnchor.constraint(equalToConstant: 187),
            scoreLabel.heightAnchor.constraint(equalToConstant: 48),
            scoreLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func startTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
        
    private func addNewPlane() {
       // guard let camera = self.sceneView.session.currentFrame?.camera else {return}
        let plane = Plane()
        self.planes.append(plane)
        self.sceneView.prepare([plane]) { [weak self] _ in
            self?.sceneView.scene.rootNode.addChildNode(plane)
        }
    }
    
    @objc func shootInfiniteBullet() {
        guard let camera = self.sceneView.session.currentFrame?.camera else { return }
        
        let bullet = Bullet(camera)
        self.sceneView.scene.rootNode.addChildNode(bullet)
    }
    
    @objc func exitButtonTapped() {
        viewModel.exitButtonTapped()
    }
}

extension GameViewController: ARSessionDelegate {
    func sessionInterruptionEnded(_ session: ARSession) {
        startTracking()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        startTracking()
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let cameraOrientation = session.currentFrame?.camera.transform else {return}
        self.planes.forEach {
            $0.face(to: cameraOrientation)
        }
    }
}

extension GameViewController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let n1 = contact.nodeA
        let n2 = contact.nodeB
        
        
        let plane: Plane = (n1 is Plane ? n1 : n2) as! Plane
        
        self.sceneView.scene.rootNode.childNodes.forEach {
            $0.removeFromParentNode()
        }
        
        Explossion.show(with: plane, in: self.sceneView.scene)
        viewModel.addScore()
        self.addNewPlane()
    }
}

extension GameViewController: GameViewDelegate {
    func scoreAdded(currentScore: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.scoreLabel.setTitle("Score: \(currentScore)", for: .normal)
        }
    }
}
