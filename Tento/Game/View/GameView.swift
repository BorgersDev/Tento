import SwiftUI
import UIKit

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    @State private var isEditingPlayer1Name = false
    @State private var isEditingPlayer2Name = false
    @State private var newUsername1 = ""
    @State private var newUsername2 = ""
    
    var body: some View {
        Group {
            ZStack {
                HStack {
                    VStack {
                        
                        player1Name
                        

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
                                .onTapGesture {
                                    isEditingPlayer2Name.toggle()
                                }
                                .alert("Mudar Nome", isPresented: $isEditingPlayer2Name) {
                                        TextField("Novo nome", text: $newUsername2)
                                        .autocorrectionDisabled()
                                        .autocapitalization(.none)
                                           Button ("Salvar"){
                                                   guard !newUsername2.isEmpty else {
                                                       return
                                                   }
                                                     viewModel.player2.name = newUsername2
                                               }
                                           Button("Cancelar", role: .cancel, action: {})
                                }
                            
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
        }.onAppear(){
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear(){
            UIApplication.shared.isIdleTimerDisabled = false

        }
    }
}

extension GameView {
    var player1Name: some View {
        Text(viewModel.player1.name)
            .font(.title)
            .onTapGesture {
                isEditingPlayer1Name.toggle()
            }
            .alert("Mudar Nome", isPresented: $isEditingPlayer1Name) {
                    TextField("Novo nome", text: $newUsername1)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                       Button ("Salvar"){
                               guard !newUsername1.isEmpty else {
                                   return
                               }
                                 viewModel.player1.name = newUsername1
                           }
                       Button("Cancelar", role: .cancel, action: {})
            }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
