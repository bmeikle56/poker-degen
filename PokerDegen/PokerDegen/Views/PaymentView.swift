//
//  PaymentView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

struct PaymentViewLayout {
    let fontSize: CGFloat
}

struct PaymentView: View {
    let navigationController: UINavigationController
    let dismiss: () -> Void
    let layout: PaymentViewLayout
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: dismiss)
            Text("Coming soon!")
                .foregroundStyle(Color.pdBlue)
                .font(.system(size: layout.fontSize))
        }
    }
}

/// iPhone
#Preview("iPhone") {
    PaymentView(
        navigationController: UINavigationController(),
        dismiss: {},
        layout: Layout.paymentView[.iPhone]!
    )
}

/// iPad
#Preview("iPad") {
    PaymentView(
        navigationController: UINavigationController(),
        dismiss: {},
        layout: Layout.paymentView[.iPad]!
    )
}
