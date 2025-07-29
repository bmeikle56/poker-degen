//
//  HelpView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/24/25.
//

import SwiftUI

struct HelpView: View {
    let navigationController: UINavigationController
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let fontSize: CGFloat
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: dismiss)
            VStack(spacing: spacing) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: fontSize))
                    .foregroundStyle(Color.pdBlue)
                Text("**Single tap** to select a card.\n\n**Double tap** to reset a card.\n\n**Single tap** the dotted regions to select a bet size, player type, and position.\n\nThen tap **Analyze** to review the hand for optimal play.")
                    .padding(.horizontal, horizontalPadding)
                    .font(.system(size: fontSize))
                    .foregroundColor(.pdBlue)
            }
        }
    }
}

/// iPhone
#Preview("iPhone") {
    HelpView(
        navigationController: UINavigationController(),
        spacing: 30,
        horizontalPadding: 60,
        fontSize: 18,
        dismiss: {}
    )
}

/// iPad
#Preview("iPad") {
    HelpView(
        navigationController: UINavigationController(),
        spacing: 50,
        horizontalPadding: 250,
        fontSize: 30,
        dismiss: {}
    )
}
