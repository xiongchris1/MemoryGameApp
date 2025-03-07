//
//  CardView.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/5/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardGameViewModel
    let card: Card
    // Tracks drag movement of card
    @State private var dragAmount: CGSize = .zero

    // Front Card
    private var cardFront: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 2)
            .overlay(
                Text(card.emoji)
                    .font(.largeTitle)
                    .shadow(radius: 1)
            )
            .opacity(card.isFaceUp ? 1 : 0)
    }
    
    // Back Card
    private var cardBack: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.blue)
            .overlay(
                DecorativePatternView()
                    .opacity(0.3)
            )
            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 2)
            .opacity(card.isFaceUp ? 0 : 1)
    }
    
    // Content of card (emojis)
    var body: some View {
        ZStack {
            cardFront
                // Flip effect
                .rotation3DEffect(
                    Angle(degrees: card.isFaceUp ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
            cardBack
                // Flip effect
                .rotation3DEffect(
                    Angle(degrees: card.isFaceUp ? 0 : 180),
                    axis: (x: 0, y: 1, z: 0)
                )
        }
        .frame(width: 100, height: 150)
        // Lowers opacity if cards are matched
        .opacity(card.isMatched ? 0.3 : 1)
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragAmount = value.translation
                }
                .onEnded { _ in
                    withAnimation(.easeOut) {
                        dragAmount = .zero
                    }
                }
        )
        // How many taps to turn card = 1
        .onTapGesture(count: 1) {
            withAnimation(.easeInOut) {
                viewModel.choose(card)
            }
        }
        .animation(.default, value: card.isFaceUp)
    }
}
