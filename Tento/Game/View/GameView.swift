import SwiftUI
struct PlayerNameEditView: View {
    @Binding var playerName: String
    @State private var editedPlayerName: String
    @State private var isPopoverPresented = false

    init(playerName: Binding<String>) {
        self._playerName = playerName
        self._editedPlayerName = State(initialValue: playerName.wrappedValue)
    }

    var body: some View {
        VStack {
            TextField("Player Name", text: $editedPlayerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Save") {
                playerName = editedPlayerName
                isPopoverPresented = false
            }
            .padding()
        }
        .padding()
        .background(Color.white)
    }
}

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var isEditingPlayerName = false
    @State private var isEditingPlayer2Name = false

    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text(viewModel.player1.name)
                        .font(.title)
                        .onTapGesture {
                            self.isEditingPlayerName = true
                        }
                        .popover(isPresented: $isEditingPlayerName, arrowEdge: .bottom) {
                            PlayerNameEditView(playerName: $viewModel.player1.name)
                        }
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
                            isEditingPlayer2Name = true
                        }
                        .popover(isPresented: $isEditingPlayer2Name, arrowEdge: .bottom) {
                            PlayerNameEditView(playerName: $viewModel.player2.name)
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
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
