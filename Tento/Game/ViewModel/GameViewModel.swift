//
//  GameViewModel.swift
//  Tento
//
//  Created by Arthur Borges on 16/02/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var player1 = Player(playerScore: 0, playerName: "player1")
    @Published var player2 = Player(playerScore: 0, playerName: "player2")
    
    func increaseScore(player: Player){
        player.increaseScore()
        self.objectWillChange.send()
    }
    func decreaseScore(player: Player){
        player.decreaseScore()
        self.objectWillChange.send()
    }
    
    class Player {
        var score: Int
        var name: String
        
        func increaseScore(){
            self.score += 1
        }
        func decreaseScore(){
            self.score -= 1
        }
        
        init(playerScore: Int, playerName: String) {
            self.score = playerScore
            self.name = playerName
        }
    }
}
