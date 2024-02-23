//
//  GameViewModel.swift
//  Tento
//
//  Created by Arthur Borges on 16/02/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published var player1 = Player(playerScore: 0, playerName: "Nós")
    @Published var player2 = Player(playerScore: 0, playerName: "Eles")
    @Published var isGameOver = false
    
    func increaseScore(player: Player){
        guard !isGameOver else {
            return
        }
        player.increaseScore()
        checkWinner()
        self.objectWillChange.send()
    }
    func decreaseScore(player: Player){
        player.decreaseScore()
        self.objectWillChange.send()
    }
    func checkWinner() {
        if player1.score == 12 || player2.score == 12 {
            isGameOver = true
        }
    }
    func restartGame() {
        self.objectWillChange.send()
        player1.score = 0
        player2.score = 0
        isGameOver = false
    }
}
