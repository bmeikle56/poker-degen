//
//  PlayerTypeSelector.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/17/25.
//

import SwiftUI

struct PlayerTypeSelector: View {
    let navigationController: UINavigationController

    @Binding var selectedPlayerType: String
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            PlayerTypeSelectorMenu(
                navigationController: navigationController,
                selectedPlayerType: $selectedPlayerType
            )
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .ignoresSafeArea(.keyboard)
    }
}
struct PlayerTypeSelectorMenu: View {
    let navigationController: UINavigationController
    @Binding var selectedPlayerType: String
    
    let playerTypes = ["Aggressive", "Tight", "Average"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Menu {
            ForEach(playerTypes, id: \.self) { playerType in
                Button(action: {
                    selectedPlayerType = playerType
                    dismiss()
                }) {
                    Text(playerType)
                        .foregroundStyle(Color.smoothGray)
                }
            }
        } label: {
            Text(selectedPlayerType)
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
