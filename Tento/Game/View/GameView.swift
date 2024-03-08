import SwiftUI
import UIKit

struct GameView: View {
    
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isEditingPlayer1Name = false
    @State private var isEditingPlayer2Name = false
    @State private var newUsername1 = ""
    @State private var newUsername2 = ""
    @State private var rotationAngle = 0.0
    var body: some View {
        Group {
            ZStack {
                HStack {
                    VStack {
                        
                        player1Name
                            .padding()
                        
                        Spacer()
                            
                        player1Score
                            .padding(.bottom,150)
                        
                        Spacer()
                        
                        player1Buttons
                            .padding(.bottom,25)

                            Spacer()
                         
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    
                    VStack (spacing:0) {
                        rotateButton
                    }
                        
                        VStack {
                            
                            player2Name
                                .padding()
                            Spacer()
                            
                            player2Score
                                .padding(.bottom,150)
                            Spacer()

                            player2Buttons
                                .padding(.bottom,25)
                            
                            Spacer()
                            
                        }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .rotationEffect(.degrees(rotationAngle))
                        .animation(.easeInOut, value: rotationAngle)
                }
                .alert(isPresented: $viewModel.isGameOver,  content: {
                    Alert(
                        title: Text(viewModel.player1.score == 12 ?
                                    "🏆 \(viewModel.player1.name) 🏆 x  💩 \(viewModel.player2.name) 💩" :  "💩 \(viewModel.player1.name) 💩 x 🏆 \(viewModel.player2.name) 🏆"),
                        message: Text("Deseja reiniciar a partida?"),
                        dismissButton: .default(Text("Reiniciar")) {
                            viewModel.restartGame()
                        }
                    )
                })
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(AdaptiveBackground())
            
                
        }.onAppear(){
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear(){
            UIApplication.shared.isIdleTimerDisabled = false

        }
    }
}
struct AdaptiveBackground: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if colorScheme == .dark {
                LinearGradient(gradient: Gradient(colors: [Color.darkStart, Color.darkEnd]), startPoint: .topLeading, endPoint: .bottomTrailing)
            } else {
                Color.offWhite
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let darkStart = Color(red: 50 / 255, green: 60 / 255, blue: 65 / 255)
    static let darkEnd = Color(red: 25 / 255, green: 25 / 255, blue: 30 / 255)
}

extension GameView {
    var player1Name: some View {
        Text(viewModel.player1.name)
            .frame(width: 100,height: 50)
            .font(.system(size: 45))
            .fontWeight(.semibold)
            .minimumScaleFactor(0.3)
                        .lineLimit(5)
                        .multilineTextAlignment(.center)
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

extension GameView {
    var player1Score: some View {
        Text("\(viewModel.player1.score)")
            .font(.system(size: 80).bold())
    }
}
extension GameView {
    var player1Buttons: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(colorScheme == . light ? Color.offWhite : Color.darkEnd)
                .frame(width: 70,height: 240)
                .shadow(color: colorScheme == .light ?  .black.opacity(0.2) : .darkStart.opacity(0.7), radius: 10, x: 10, y: 10)
                .shadow(color: colorScheme == .light ?  .white.opacity(0.7) : .darkEnd, radius: 10, x: -5, y: -5)
            VStack (spacing: 0) {
                
                Button(action: {
                    viewModel.increaseScore(player: viewModel.player1)
                }) {
                    Image(systemName: "plus")
                        .frame(width: 75, height: 80)
                        .font(.largeTitle)
                        
                        
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)
                    
                
                Button(action: {
                    viewModel.increaseScoreByThree(player: viewModel.player1)
                }) {
                    Text("+3")
                        .frame(width: 75, height: 80)
                        .font(.system(size: 33))
                        
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)

                Button(action: {
                    viewModel.decreaseScore(player: viewModel.player1)
                }) {
                    Image(systemName: "minus")
                        .frame(width: 75, height: 80)
                        .font(.largeTitle)
                        
                    
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)
                
            }.foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                .cornerRadius(50)
        }
         
    }
}
extension GameView {
    var rotateButton: some View {
        
        Button(action: {
            guard rotationAngle.isZero else {
               return rotationAngle = 0.0
            }
            rotationAngle = 180.0
        }) {
            Image(systemName: "arrow.triangle.2.circlepath")
                .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                .rotationEffect(.degrees(rotationAngle * 2.0))
                .animation(.easeInOut.speed(0.4), value: rotationAngle)
        }
    }
}
extension GameView {
    var player2Name: some View {
        Text(viewModel.player2.name)
            .frame(width: 100,height: 50)
            .font(.system(size: 40))
            .fontWeight(.semibold)
            .minimumScaleFactor(0.5)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
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
    }
}
extension GameView {
    var player2Score: some View {
        Text("\(viewModel.player2.score)")
            .font(.system(size: 80).bold())
    }
}
extension GameView {
    var player2Buttons: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(colorScheme == . light ? Color.offWhite : Color.darkEnd)
                .frame(width: 70,height: 240)
                .shadow(color: colorScheme == .light ?  .black.opacity(0.2) : .darkStart.opacity(0.7), radius: 10, x: 10, y: 10)
                .shadow(color: colorScheme == .light ?  .white.opacity(0.7) : .darkEnd, radius: 10, x: -5, y: -5)
            VStack (spacing: 0) {
                
                Button(action: {
                    viewModel.increaseScore(player: viewModel.player2)
                }) {
                    Image(systemName: "plus")
                        .frame(width: 75, height: 80)
                        .font(.system(size: 33))
                        
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)
                
                Button(action: {
                    viewModel.increaseScoreByThree(player: viewModel.player2)
                }) {
                    Text("+3")
                        .frame(width: 75, height: 80)
                        .font(.system(size: 33))
                        
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)
                
                Button(action: {
                    viewModel.decreaseScore(player: viewModel.player2)
                }) {
                    Image(systemName: "minus")
                        .frame(width: 75, height: 80)
                        .font(.largeTitle)
                    
                }.background(colorScheme == .light ? Color.offWhite : Color.darkEnd)
                    
            }.foregroundStyle(colorScheme == .light ? Color.black : Color.white)
                .cornerRadius(50)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}
