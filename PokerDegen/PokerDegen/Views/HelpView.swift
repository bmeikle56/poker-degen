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
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.title2)
                        .foregroundStyle(Color.pdBlue)
                })
                Spacer()
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 25)
            Spacer().frame(height: 150)
            VStack(spacing: 20) {
                Image(systemName: "questionmark.circle")
                    .font(.title2)
                    .foregroundStyle(Color.pdBlue)
                Text("**Single tap** to select a card.\n\n**Double tap** to reset a card.\n\n**Single tap** the dotted regions to select a bet size, player type, and position.\n\nThen tap **Analyze** to review the hand for optimal play.")
                    .frame(width: 300)
                    .foregroundColor(.pdBlue)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
