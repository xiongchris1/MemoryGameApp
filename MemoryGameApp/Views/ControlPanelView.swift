//
//  ControlPanel.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/7/25.
//

import SwiftUI

struct ControlPanel: View {
    @ObservedObject var gameViewModel: CardGameViewModel

    var body: some View {
        VStack(spacing: 10) {
            // Score and Moves Display
            HStack {
                Text("Score: \(gameViewModel.score)")
                    .font(.headline)
                Spacer()
                Text("Moves: \(gameViewModel.moves)")
                    .font(.headline)
            }
            
            // Game Control Buttons
            HStack {
                Button("New Game") {
                    withAnimation(.spring()) {
                        gameViewModel.startNewGame()
                    }
                }
                Spacer()
                Button("Shuffle") {
                    withAnimation(.spring()) {
                        gameViewModel.shuffleCards()
                    }
                }
            }
            
            // Game Over Message
            if gameViewModel.gameOver {
                Text("Game Over!")
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        ControlPanel(gameViewModel: CardGameViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
