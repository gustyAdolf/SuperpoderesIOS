//
//  ImageDetailViewModel.swift
//  Reconocimiento objetos
//
//  Created by Gustavo A Ramírez Franco on 15/4/21.
//

import Vision
import QuartzCore
import UIKit


protocol ImageDetailCoordinatorDelegate: class {
    
}

protocol ImageDetailViewDelegate: class {
    
    func didPredict(observations: [VNDetectedObjectObservation], objectsName: String)
}

class ImageDetailViewModel {
    
    weak var coordinateDelegate: ImageDetailCoordinatorDelegate?
    weak var viewDelegate: ImageDetailViewDelegate?
    let imageData: Data
    let model = try? YOLO(configuration: MLModelConfiguration())
    
    private var requests = [VNRequest]()
    
    init(imageData: Data) {
        self.imageData = imageData
        guard let model = model?.model,
              let visionModel = try? VNCoreMLModel(for: model) else {fatalError()}
        
       let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestCompleted)
        
        self.requests = [objectRecognition]
    }
    
 
    func predict() {
        guard let pixelBuffer = UIImage(data: imageData)?.resize().pixelBuffer else {return}
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    private func visionRequestCompleted(request: VNRequest, error: Error?) {
        if let results = request.results {
            CATransaction.begin()
            CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
            
            var objectsName = ""
            
            for observation in results where observation is VNRecognizedObjectObservation {
                guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                    continue
                }
                // Select only the label with the highest confidence.
                let topLabelObservation = objectObservation.labels[0]
                objectsName.append("\(topLabelObservation.identifier), ")
            }
            
            
            guard let observations = results as? [VNDetectedObjectObservation] else {return}
            self.viewDelegate?.didPredict(observations: observations, objectsName: objectsName)
            CATransaction.commit()
        }
    }
}



