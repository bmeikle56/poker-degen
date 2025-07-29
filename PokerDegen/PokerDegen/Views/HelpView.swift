//
//  HelpView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/24/25.
//

import SwiftUI

struct HelpView: View {
    let navigationController: UINavigationController
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: dismiss)
            VStack(spacing: 20) {
                Image(systemName: "questionmark.circle")
                    .font(.title2)
                    .foregroundStyle(Color.pdBlue)
                Text("**Single tap** to select a card.\n\n**Double tap** to reset a card.\n\n**Single tap** the dotted regions to select a bet size, player type, and position.\n\nThen tap **Analyze** to review the hand for optimal play.")
                    .frame(width: 300)
                    .foregroundColor(.pdBlue)
            }
        }
    }
}
