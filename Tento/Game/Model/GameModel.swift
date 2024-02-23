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
        self.score += 3
    }
    func decreaseScore(){
        guard score > 0 else {
            // does nothing
            return
        }
        self.score -= 1
    }
    func decreaseByThree() {
        guard score > 0 else {
            // does nothing
            return
        }
        self.score -= 3
    }
    
    init(playerScore: Int, playerName: String) {
        self.score = playerScore
        self.name = playerName
    }
}
