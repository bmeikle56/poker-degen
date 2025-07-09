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
    @Binding var toggle: Bool
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            if selecting == "card" {
                /// our card is empty...
            } else {
                selecting = String(selecting.prefix(1)) + value
            }
            toggle.toggle()
        }) {
            Text(suit)
                .foregroundStyle(color)
                .font(.system(size: 36))
        }
    }
}

struct Rank: View {
    let rank: String
    @Binding var selecting: String
    @Binding var toggle: Bool
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            if selecting == "card" {
                /// our card is empty...
            } else {
                selecting = rank.lowercased() + String(selecting.suffix(1))
            }
            toggle.toggle()
            dismiss()
        }) {
            Text(rank)
                .foregroundStyle(Color.black)
                .font(.system(size: 24))
        }
    }
}

struct CardSelector: View {
    let navigationController: UINavigationController
    @Binding var card: String
    
    
    @State private var showSuitSelector: Bool = true

    var body: some View {
        VStack(spacing: 10) {
            if showSuitSelector {
                HStack(spacing: 20) {
                    Suit(suit: "♠︎", color: .black, value: "s", selecting: $card, toggle: $showSuitSelector)
                    Suit(suit: "♥︎", color: .red, value: "h", selecting: $card, toggle: $showSuitSelector)
                }
                HStack(spacing: 20) {
                    Suit(suit: "♦︎", color: .red, value: "d", selecting: $card, toggle: $showSuitSelector)
                    Suit(suit: "♣︎", color: .black, value: "c", selecting: $card, toggle: $showSuitSelector)
                }
            } else {
                HStack(spacing: 20) {
                    Rank(rank: "A", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "K", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "Q", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "J", selecting: $card, toggle: $showSuitSelector)
                }
                HStack(spacing: 20) {
                    Rank(rank: "T", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "9", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "8", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "7", selecting: $card, toggle: $showSuitSelector)
                }
                HStack(spacing: 20) {
                    Rank(rank: "6", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "5", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "4", selecting: $card, toggle: $showSuitSelector)
                    Rank(rank: "3", selecting: $card, toggle: $showSuitSelector)
                }
                HStack(spacing: 20) {
                    Rank(rank: "2", selecting: $card, toggle: $showSuitSelector)
                }
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
