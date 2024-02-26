//
//  GameModel.swift
//  Tento
//
//  Created by Arthur Borges on 17/02/24.
//

import Foundation

class Player {
     @Published var score: Int
     @Published var name: String
    
    func increaseScore(){
        guard score < 12 else {
            // player won
            return
        }
        self.score += 1
    }
    func increaseByThree() {
        guard score < 12 else {
            // player won
            return
        }
        switch self.score {
        case 10 : self.score += 2
        case 11 : self.score += 1
        default : self.score += 3
        }
    }
    func decreaseScore(){
        guard score > 0 else {
            // does nothing
            return
        }
        self.score -= 1
    }
    
    init(playerScore: Int, playerName: String) {
        self.score = playerScore
        self.name = playerName
    }
}
