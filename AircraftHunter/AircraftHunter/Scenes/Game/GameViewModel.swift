//
//  GameViewModel.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import Foundation

protocol GameCoordinatorDelegate: class {
    func exitButtonTapped()
}

protocol GameViewDelegate: class {
    func scoreAdded(currentScore: Int)
}

class GameViewModel {
    weak var coordinateDelegate: GameCoordinatorDelegate?
    weak var viewDelegate: GameViewDelegate?
    var currentScore: Int = 0
    
    func addScore() {
        currentScore += 1
        viewDelegate?.scoreAdded(currentScore: currentScore)
    }
    
    func exitButtonTapped() {
        let hightScore = UserDefaults.standard.integer(forKey: "score")
        
        if currentScore > hightScore {
            UserDefaults.standard.setValue(currentScore, forKey: "score")
        }
        self.coordinateDelegate?.exitButtonTapped()
    }
    
}
