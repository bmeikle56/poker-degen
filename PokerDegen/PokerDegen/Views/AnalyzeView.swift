//
//  AnalyzeView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/15/25.
//

import SwiftUI

struct AnalyzeViewLayout {
    let fontSize: CGFloat
    let actionViewWidth: CGFloat
    let actionViewHeight: CGFloat
    let gaugeWidth: CGFloat
    let gaugeHeight: CGFloat
}

struct ActionView: View {
    let icon: String
    let action: String
    let isCorrect: Bool
    let fontSize: CGFloat
    let actionViewWidth: CGFloat
    let actionViewHeight: CGFloat

    var body: some View {
        HStack {
            Text(icon)
                .font(.system(size: fontSize))
            Text(action)
                .font(.system(size: fontSize))
        }
        .padding()
        .frame(width: actionViewWidth, height: actionViewHeight)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isCorrect ? Color.green.opacity(0.7) : Color.gray.opacity(0.05))
        )
    }
}
struct HorizontalGauge: View {
    let value: Double // 0.0 to 1.0
    let gaugeWidth: CGFloat
    let gaugeHeight: CGFloat
    
    private var fillColor: Color {
        switch value {
        case 0..<0.25:
            return .yellow
        case 0.25..<0.5:
            return .orange
        case 0.5..<0.75:
            return .red
        case 0.75..<0.9:
            return Color(red: 0.7, green: 0.0, blue: 0.0)
        default:
            return Color(red: 0.7, green: 0.0, blue: 0.5)
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(height: gaugeHeight)
                .foregroundColor(.gray.opacity(0.1))
            Capsule()
                .frame(width: gaugeWidth * value, height: gaugeHeight)
                .foregroundColor(fillColor)
        }
        .frame(width: gaugeWidth, height: gaugeHeight)
    }
}

struct AnalyzeView: View {
    let layout: AnalyzeViewLayout

    @Binding var showPopover: Bool
    @Binding var modelResponse: [String]?
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                Spacer().frame(height: 40)
                ActionView(
                    icon: "✋",
                    action: "Check",
                    isCorrect: modelResponse![0] == "Check",
                    fontSize: layout.fontSize,
                    actionViewWidth: layout.actionViewWidth,
                    actionViewHeight: layout.actionViewHeight,
                )
                ActionView(
                    icon: "💰",
                    action: "Bet",
                    isCorrect: modelResponse![0] == "Bet",
                    fontSize: layout.fontSize,
                    actionViewWidth: layout.actionViewWidth,
                    actionViewHeight: layout.actionViewHeight,
                )
                ActionView(
                    icon: "🗑️",
                    action: "Fold",
                    isCorrect: modelResponse![0] == "Fold",
                    fontSize: layout.fontSize,
                    actionViewWidth: layout.actionViewWidth,
                    actionViewHeight: layout.actionViewHeight,
                )
                Spacer().frame(height: 40)
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Villain's range")
                            .font(.system(size: layout.fontSize))
                        Text("Hero's range")
                            .font(.system(size: layout.fontSize))
                    }
                    VStack(spacing: 16) {
                        HorizontalGauge(
                            value: Double(modelResponse![1].trimmingCharacters(in: .whitespacesAndNewlines))!,
                            gaugeWidth: layout.gaugeWidth,
                            gaugeHeight: layout.gaugeHeight
                        )
                        HorizontalGauge(
                            value: Double(modelResponse![2].trimmingCharacters(in: .whitespacesAndNewlines))!,
                            gaugeWidth: layout.gaugeWidth,
                            gaugeHeight: layout.gaugeHeight
                        )
                    }
                }
                Spacer().frame(height: 40)
                if let modelResponse {
                    MarkdownView(markdownString: modelResponse[3].trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.system(size: layout.fontSize, weight: .regular, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.gray.opacity(0.05))
                        )
                }
            }
            Button(action: {
                showPopover = false
            }, label: {
                Text("Close")
                    .font(.system(size: layout.fontSize))
            })
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

let mockModelResponse = [
    "Bet",
    "0.352",
    "0.648",
    "Hero holds bottom set (222) on a monotone board (As Ks 2s), while Villain has the nut flush draw and a gutshot to broadway. Betting is the highest EV action because Hero is currently ahead with a strong made hand but is vulnerable to many turn and river cards. Betting extracts value from worse hands (including draws) and denies Villain a free card that could shift equity. Against an aggressive Villain, a bet also invites potential bluffs or semibluff raises."
]

/// iPhone
#Preview("iPhone") {
    AnalyzeView(
        layout: Layout.analyzeView[.iPhone]!,
        showPopover: .constant(true),
        modelResponse: .constant(mockModelResponse)
    )
}

/// iPad
#Preview("iPad") {
    AnalyzeView(
        layout: Layout.analyzeView[.iPad]!,
        showPopover: .constant(true),
        modelResponse: .constant(mockModelResponse)
    )
}
