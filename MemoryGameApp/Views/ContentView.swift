//
//  ContentView.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameViewModel = CardGameViewModel()
    @State private var isLandscape = false
    
    var body: some View {
        GeometryReader { geometry in
            // Landscape based on width vs height
            let isLandscapeNow = geometry.size.width > geometry.size.height
            
            ZStack {
                // Background color
                Color(red: 0.85, green: 0.97, blue: 1.0)
                    .ignoresSafeArea()
                
                // Layout changes based on orientation
                if isLandscape {
                    // LANDSCAPE LAYOUT
                    HStack{
                        // Cards
                        cardGrid(screenSize: geometry.size)
                            .frame(minWidth: 0, maxWidth: .infinity)
                        // Control Panel
                        ControlPanel(gameViewModel: gameViewModel)
                            .frame(width: geometry.size.width * 0.3)
                    }
                } else {
                    // PORTRAIT LAYOUT
                    VStack {
                        cardGrid(screenSize: geometry.size)
                        ControlPanel(gameViewModel: gameViewModel)
                    }
                    .padding()
                }
            }
            // Update orientation
            .onAppear {
                isLandscape = isLandscapeNow
            }
            .onChange(of: isLandscapeNow) { oldValue, newValue in
                withAnimation(.spring()) {
                    isLandscape = newValue
                }
            }
        }
    }
    
    // MARK: - Helper Method for Card Grid
    private func cardGrid(screenSize: CGSize) -> some View {
        
        let isLandscape = screenSize.width > screenSize.height
        
        let minWidth: CGFloat = isLandscape ? 100: 80
            
        return ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: minWidth))], spacing: 2) {
                // Show each card in the game
                ForEach(gameViewModel.cards) { card in
                    CardView(viewModel: gameViewModel, card: card)
                        // Card aspect ratio is 2:3
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
