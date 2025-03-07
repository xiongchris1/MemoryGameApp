//
//  DecorativePatternView.swift
//  MemoryGameApp
//
//  Created by Chris Xiong on 3/6/25.
//

import SwiftUI

struct DecorativePatternView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            Path { path in
                // Line left to right[
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: width, y: height))
                
                // Line right to left
                path.move(to: CGPoint(x: width, y: 0))
                path.addLine(to: CGPoint(x: 0, y: height))
            }
            .stroke(Color.white.opacity(0.5), lineWidth: 4)
        }
    }
}
