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
    @Environment(\.dismiss) var dismiss
    let layout: PaymentViewLayout
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: { dismiss() })
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
        layout: Layout.paymentView[.iPhone]!
    )
}

/// iPad
#Preview("iPad") {
    PaymentView(
        navigationController: UINavigationController(),
        layout: Layout.paymentView[.iPad]!
    )
}
