//
//  ContentView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            HStack {
                DiamondShape()
                    .stroke(Color.pdBlue, lineWidth: 4)
                    .frame(width: 20, height: 40)
                Spacer().frame(width: 20)
                Text("PokerDegen")
                    .foregroundStyle(Color.pdBlue)
                    .font(.system(size: 34, weight: .bold, design: .default))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView()
}
