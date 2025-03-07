//
//  Card.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/5/25.
//

import SwiftUI

struct Card: Identifiable {
    let id: Int
    let emoji: String
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var position: CGFloat = 0
}
