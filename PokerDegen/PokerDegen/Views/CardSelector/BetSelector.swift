//
//  BetSelector.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/16/25.
//

import SwiftUI

struct BetSelector: View {
    let navigationController: UINavigationController

    @Binding var bet: Int
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            BetField(bet: $bet)
            Button(action: {
                dismiss()
            }, label: {
                Text("Done")
            })
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .ignoresSafeArea(.keyboard)
    }
}

struct BetField: View {
    @Binding var bet: Int
    @State private var betText: String = ""

    var body: some View {
        ZStack(alignment: .leading) {
            if betText.isEmpty {
                Text("Bet Size")
                    .foregroundColor(.smoothGray)
                    .padding(.horizontal, 16)
            }

            TextField("", text: $betText)
                .keyboardType(.numberPad)
                .onChange(of: betText) { newValue in
                    // Remove non-digit characters
                    let digitsOnly = newValue.filter { $0.isNumber }

                    // Convert to Int and cap it
                    if let intValue = Int(digitsOnly) {
                        bet = min(intValue, 500)
                        betText = String(bet) // ensure UI reflects cap
                    } else {
                        bet = 0
                        betText = ""
                    }
                }
                .onAppear {
                    // Sync initial value
                    betText = bet > 0 ? String(bet) : ""
                }
                .padding()
                .frame(maxWidth: 100)
                .foregroundStyle(Color.smoothGray)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 1.4))
                        .foregroundStyle(Color.smoothGray)
                )
        }
    }
}
