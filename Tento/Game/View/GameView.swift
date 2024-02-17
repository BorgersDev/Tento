//
//  GameView.swift
//  Tento
//
//  Created by Arthur Borges on 16/02/24.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text(viewModel.player1.name)
                        .font(.title)

                    Text("\(viewModel.player1.score)")
                        .font(.largeTitle)
                    
                    HStack {
                        Button(action: {
                            viewModel.decreaseScore(player: viewModel.player1)
                        }) {
                            Image(systemName: "minus.circle.fill")
                                .font(.largeTitle)
                        }
                        
                        Button(action: {
                            viewModel.increaseScore(player: viewModel.player1)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                        }
                    }
                }.padding()
                    
                    VStack {
                        Text(viewModel.player2.name)
                            .font(.title)
                        Text("\(viewModel.player2.score)")
                                  .font(.largeTitle)
                                
                                HStack {
                                    Button(action: {
                                        viewModel.decreaseScore(player: viewModel.player2)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .font(.largeTitle)
                                    }
                                    
                                    Button(action: {
                                        viewModel.increaseScore(player: viewModel.player2)
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.largeTitle)
                                    }
                                }
                    }.padding()
            }
            .alert(isPresented: $viewModel.isGameOver,  content: {
                Alert(
                    title: Text("🎉 \(viewModel.player1.score == 12 ? viewModel.player1.name : viewModel.player2.name) ganhou!! 🎉"),
                    message: Text("Clique abaixo para começar a próxima partida."),
                    dismissButton: .default(Text("Recomeçar")) {
                        viewModel.restartGame()
                    }
                )
            })
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
