//
//  PaymentView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

struct PaymentView: View {
    let navigationController: UINavigationController
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: dismiss)
            Text("Coming soon!")
                .foregroundStyle(Color.pdBlue)
        }
    }
}
