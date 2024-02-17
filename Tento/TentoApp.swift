//
//  TentoApp.swift
//  Tento
//
//  Created by Arthur Borges on 15/02/24.
//

import SwiftUI

@main
struct TentoApp: App {
    var body: some Scene {
        WindowGroup {
            GameView(viewModel: GameViewModel())
        }
    }
}
