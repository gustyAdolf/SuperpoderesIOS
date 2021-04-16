//
//  ImageDetailViewController.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import UIKit
import Vision
import AVFoundation


class ImageDetailViewController: UIViewController {
    
    let viewModel: ImageDetailViewModel
    private var maskLayer = [CAShapeLayer]()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: viewModel.imageNamed)
        return imageView
    }()
    
    lazy var labelExample: UILabel = {
        let labelExample = UILabel()
        labelExample.translatesAutoresizingMaskIntoConstraints = false
        labelExample.backgroundColor = .gray
        return labelExample
    }()
    
    
    init(viewModel: ImageDetailViewModel) {
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
        viewModel.predict()
    }
    
    
    private func setupConstraints() {
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(labelExample)
        NSLayoutConstraint.activate([
            labelExample.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelExample.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
        
        
    }
    
    
    func visualizeObservations(observations: [VNDetectedObjectObservation], objectsName: String) {
        DispatchQueue.main.async {
            guard let image = self.imageView.image else {return}
            
            let imageSize = image.size
            var imageTransform = CGAffineTransform.identity.scaledBy(x: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)
            imageTransform = imageTransform.scaledBy(x: imageSize.width, y: imageSize.height)
            UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
           
            let graphicsContext = UIGraphicsGetCurrentContext()
            image.draw(in: CGRect(origin: .zero, size: imageSize))
            graphicsContext?.saveGState()
            graphicsContext?.setLineJoin(.round)
            graphicsContext?.setLineWidth(4.0)
            graphicsContext?.setFillColor(red: 0, green: 1, blue: 0, alpha: 0.3)
            graphicsContext?.setStrokeColor(UIColor.green.cgColor)
            
            observations.forEach { (observation) in
            
                let observationBounds = observation.boundingBox.applying(imageTransform)
                graphicsContext?.addRect(observationBounds)
            }
            self.labelExample.text = objectsName
            graphicsContext?.drawPath(using: CGPathDrawingMode.fillStroke)
            graphicsContext?.restoreGState()
            
            let drawnImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            self.imageView.image = drawnImage
        }
    }
    
}

extension ImageDetailViewController: ImageDetailViewDelegate {
    func didPredict(observations: [VNDetectedObjectObservation], objectsName: String) {
        visualizeObservations(observations: observations, objectsName: objectsName)
    }
}

