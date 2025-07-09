//
//  CardSelector.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct Suit: View {
    let suit: String
    let color: Color
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Text(suit)
                .foregroundStyle(color)
                .font(.system(size: 36))
        }
    }
}

struct CardSelector: View {
    let navigationController: UINavigationController

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Suit(suit: "♠︎", color: .black)
                Suit(suit: "♥︎", color: .red)
            }
            HStack(spacing: 20) {
                Suit(suit: "♦︎", color: .red)
                Suit(suit: "♣︎", color: .black)
            }
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    CardSelector(navigationController: UINavigationController())
}
