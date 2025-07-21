//
//  PositionSelector.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/17/25.
//

import SwiftUI

struct PositionSelector: View {
    let navigationController: UINavigationController

    @Binding var selectedPosition: String
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            PokerPositionMenu(
                navigationController: navigationController,
                selectedPosition: $selectedPosition
            )
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .ignoresSafeArea(.keyboard)
    }
}
struct PokerPositionMenu: View {
    let navigationController: UINavigationController
    @Binding var selectedPosition: String
    
    let positions = ["UTG", "+1", "LJ", "HJ", "CO", "BTN", "SB", "BB"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Menu {
            ForEach(positions, id: \.self) { position in
                Button(action: {
                    selectedPosition = position
                    dismiss()
                }) {
                    Text(position)
                        .foregroundStyle(Color.smoothGray)
                }
            }
        } label: {
            Text(selectedPosition)
                .font(.headline)
                .foregroundColor(.smoothGray)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 1.4))
                        .foregroundStyle(Color.smoothGray)
                )
        }
    }
}
