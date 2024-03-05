//
//  splashView.swift
//  Tento
//
//  Created by Arthur Borges on 19/02/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive: Bool = false
    var body: some View {
        ZStack {
            VStack {
                Image(colorScheme == .light ? "tentoBlack" : "tentoWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

            }
        }.background(colorScheme == . light ? Color.offWhite : Color.darkEnd)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive, content: {
            GameView(viewModel: GameViewModel())
        })
    }
}

#Preview {
    SplashView()
}
