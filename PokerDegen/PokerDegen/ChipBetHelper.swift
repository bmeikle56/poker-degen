//
//  ChipBetHelper.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/29/25.
//

import SwiftUI

func chipBreakdown(for bet: Int) -> [(Int, Int)] {
    let denominations = [500, 50, 10, 1]
    var remaining = bet
    var chips: [(Int, Int)] = []

    for denom in denominations {
        let count = remaining / denom
        if count > 0 {
            chips.append((denom, count))
            remaining %= denom
        }
    }

    return chips
}

@ViewBuilder func betUI(for bet: Int) -> some View {
    if bet == 0 {
        Spacer()
            .frame(width: 80, height: 30)
    } else {
        let chipBreakdown = chipBreakdown(for: bet)
        
        HStack {
            ForEach(chipBreakdown, id: \.0) { chip in
                StackedChipsView(count: chip.1, type: "chip-\(chip.0)")
            }
        }
    }
}
