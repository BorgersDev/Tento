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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
