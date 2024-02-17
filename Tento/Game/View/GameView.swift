//
//  GameView.swift
//  Tento
//
//  Created by Arthur Borges on 16/02/24.
//

import SwiftUI

struct GameView: View {
    @State private var count = 0
    var body: some View {
        VStack {
                    Text("\(count)")
                      .font(.largeTitle)
                    
                    HStack {
                        Button(action: {
                            count -= 1
                        }) {
                            Image(systemName: "minus.circle")
                                .font(.largeTitle)
                        }
                        
                        Button(action: {
                            count += 1
                        }) {
                            Image(systemName: "plus.circle")
                                .font(.largeTitle)
                        }
                    }
                }
    }
}

#Preview {
    GameView()
}
