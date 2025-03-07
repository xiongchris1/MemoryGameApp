//
//  CardGameViewModel.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/5/25.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score: Int = 0
    @Published var moves: Int = 0
    @Published var gameOver: Bool = false

    private var firstSelectedCardIndex: Int? = nil
    
    // Emojis/Card content
    private let emojis: [String] = ["🐸", "🦁", "📱", "🥊", "⚽️", "❤️"]
    
    // Start game
    init() {
        startNewGame()
    }
    
    func startNewGame() {
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCardIndex = nil
        
        // Create pairs of cards from the emojis array
        var newCards: [Card] = []
        var id = 0
        
        for emoji in emojis {
            let card1 = Card(
                id: id,
                emoji: emoji,
                isFaceUp: false,
                isMatched: false,
                position: 0
            )
            id += 1
            
            let card2 = Card(
                id: id,
                emoji: emoji,
                isFaceUp: false,
                isMatched: false,
                position: 0
            )
            id += 1
            
            newCards.append(contentsOf: [card1, card2])
        }
        
        // Random card positions
        self.cards = newCards.shuffled()
    }
    
    func dealCards() {
        for index in cards.indices {
            // Using dispatchqueue to delay cards to make it look like dealing cards animation
            // source: https://developer.apple.com/documentation/dispatch/dispatchqueue
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                self.cards[index].position = 0
            }
        }
    }
    
    // Randomizes the card positions.
    func shuffleCards() {
        cards.shuffle()
    }
    
    // Card selection logic
    func choose(_ selectedCard: Card) {
        // Index of selected card
        guard let index = cards.firstIndex(where: { $0.id == selectedCard.id }) else { return }
        
        // Ignore if the card is already face up or matched[
        if cards[index].isFaceUp || cards[index].isMatched {
            return
        }
        
        // Turns selected card face up
        cards[index].isFaceUp = true
        
        if let firstIndex = firstSelectedCardIndex {
            // Increments moves and check for match
            moves += 1
            
            if cards[firstIndex].emoji == cards[index].emoji {
                cards[firstIndex].isMatched = true
                cards[index].isMatched = true
                score += 2
                
                // Gameover when all cards matched
                if cards.allSatisfy({ $0.isMatched }) {
                    gameOver = true
                }
            } else {
                // Lose points for cards that don't match
                if score > 0 {
                    score -= 1
                }
                // Flip both cards back down after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    self.cards[firstIndex].isFaceUp = false
                    self.cards[index].isFaceUp = false
                }
            }
            firstSelectedCardIndex = nil
        } else {
            for i in cards.indices {
                if !cards[i].isMatched && i != index {
                    cards[i].isFaceUp = false
                }
            }
            firstSelectedCardIndex = index
        }
    }
}
