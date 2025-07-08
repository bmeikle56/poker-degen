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

struct PokerTable: View {
    var body: some View {
        GeometryReader { geo in
            let scale: CGFloat = 0.75
            let width = geo.size.width * scale
            let height = geo.size.height * scale

            ZStack {
                Capsule()
                    .fill(Color.green.opacity(0.3))
                    .rotation3DEffect(
                            .degrees(40),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )
                Capsule()
                    .stroke(Color.pokerMaroon, lineWidth: 6)
                    .rotation3DEffect(
                            .degrees(40),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )
            }
            .frame(width: width, height: height)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(radius: 10)
        }
        .aspectRatio(0.6, contentMode: .fit) // Vertical layout
        .padding()
    }
}
