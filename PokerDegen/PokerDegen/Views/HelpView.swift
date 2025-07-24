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
            Spacer()
            VStack {
                Text("Help goes here")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Help goes here 2")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
