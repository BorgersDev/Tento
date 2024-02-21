import SwiftUI
//struct PlayerNameEditView: View {
//    @Binding var playerName: String
//    @State private var editedPlayerName: String
//    @Binding var isPresented: Bool
//
//    init(playerName: Binding<String>, isPresented: Binding<Bool>) {
//        self._playerName = playerName
//        self._editedPlayerName = State(initialValue: playerName.wrappedValue)
//        self._isPresented = isPresented
//    }
//
//    var body: some View {
//        VStack {
//            Text("Novo nome :")
//                .font(.title.bold())
//                .padding(.bottom, 10)
//            TextField("Nos", text: $editedPlayerName)
//                .padding(.vertical, 6)
//                .multilineTextAlignment(.center)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10.0)
//                        .stroke(lineWidth: 0.8)
//                )
//                .frame(width: 100)
//                .disableAutocorrection(true)
//                .autocapitalization(.none)
////                .padding(.horizontal,100)
//
//            Button("Salvar") {
//                playerName = editedPlayerName
//                isPresented = false
//            }
//            .frame(width: 70)
//            .padding(.vertical, 4)
//            .padding(.horizontal, 5)
//            .font(.callout)
//            .background(Color(.blue))
//            .foregroundColor(.white)
//            .cornerRadius(10.0)
//            .padding(.top, 15)
//        }
//        .padding()
//    }
//}
struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    @State private var isEditingPlayer1Name = false
    @State private var isEditingPlayer2Name = false
    @State private var newUsername = ""
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text(viewModel.player1.name)
                        .font(.title)
                        .onTapGesture {
                            isEditingPlayer1Name.toggle()
                        }
                        .alert("Mudar Nome", isPresented: $isEditingPlayer1Name) {
                                TextField("Novo nome", text: $newUsername)
                                   Button ("Salvar"){
                                           guard !newUsername.isEmpty else {
                                               return
                                           }
                                             viewModel.player1.name = newUsername
                                       }
                                   Button("Cancel", role: .cancel, action: {})
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
                                isEditingPlayer2Name.toggle()
                            }
//                            .sheet(isPresented: $isEditingPlayer2Name){
//                                PlayerNameEditView(playerName: $viewModel.player2.name, isPresented: $isEditingPlayer2Name)
//                            }
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
