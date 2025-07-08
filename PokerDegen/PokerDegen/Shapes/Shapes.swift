//
//  Shapes.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.midX
        let midY = rect.midY
        
        path.move(to: CGPoint(x: midX, y: rect.minY)) // Top
        path.addLine(to: CGPoint(x: rect.maxX, y: midY)) // Right
        path.addLine(to: CGPoint(x: midX, y: rect.maxY)) // Bottom
        path.addLine(to: CGPoint(x: rect.minX, y: midY)) // Left
        path.closeSubpath()
        
        return path
    }
}
