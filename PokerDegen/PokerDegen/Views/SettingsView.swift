//
//  SettingsView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

struct SettingsView: View {
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
            Spacer()
            Text("Disable FaceID")
                .foregroundStyle(Color.pdBlue)
            Text("Log out")
                .foregroundStyle(Color.pdBlue)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
