//
//  TitleScreenViewModel.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import Foundation

protocol TitleScreenCoordinatorDelegate: class {
    func startGameTapped()
}

class TitleScreenViewModel {
    weak var coordinateDelegate: TitleScreenCoordinatorDelegate?
    var lastScore: Int = UserDefaults.standard.integer(forKey: "score")
    
    func startGameTapped(){
        self.coordinateDelegate?.startGameTapped()
    }
    
    func updateScore() {
        lastScore = UserDefaults.standard.integer(forKey: "score")
    }
}
