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
    let value: String
    @Binding var selecting: String
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            if selecting == "card" {
                /// our card is empty...
            } else {
                selecting = String(selecting.prefix(1)) + value
            }
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
    @Binding var card: String

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                Suit(suit: "♠︎", color: .black, value: "s", selecting: $card)
                Suit(suit: "♥︎", color: .red, value: "h", selecting: $card)
            }
            HStack(spacing: 20) {
                Suit(suit: "♦︎", color: .red, value: "d", selecting: $card)
                Suit(suit: "♣︎", color: .black, value: "c", selecting: $card)
            }
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

//#Preview {
//    CardSelector(
//        navigationController: UINavigationController(),
//        card: "hc1"
//    )
//}
