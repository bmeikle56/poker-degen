//
//  HelpView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/24/25.
//

import SwiftUI

struct HelpViewLayout {
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    let fontSize: CGFloat
}

struct HelpView: View {
    let navigationController: UINavigationController
    let dismiss: () -> Void
    
    let layout: HelpViewLayout
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: dismiss)
            VStack(spacing: layout.spacing) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: layout.fontSize))
                    .foregroundStyle(Color.pdBlue)
                Text("**Single tap** to select a card.\n\n**Double tap** to reset a card.\n\n**Single tap** the dotted regions to select a bet size, player type, and position.\n\nThen tap **Analyze** to review the hand for optimal play.")
                    .padding(.horizontal, layout.horizontalPadding)
                    .font(.system(size: layout.fontSize))
                    .foregroundColor(.pdBlue)
            }
        }
    }
}

/// iPhone
#Preview("iPhone") {
    HelpView(
        navigationController: UINavigationController(),
        dismiss: {},
        layout: HelpViewLayout(
            spacing: 30,
            horizontalPadding: 60,
            fontSize: 18
        )
    )
}

/// iPad
#Preview("iPad") {
    HelpView(
        navigationController: UINavigationController(),
        dismiss: {},
        layout: HelpViewLayout(
            spacing: 50,
            horizontalPadding: 250,
            fontSize: 30
        )
    )
}
