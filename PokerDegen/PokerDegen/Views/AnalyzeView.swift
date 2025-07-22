//
//  AnalyzeView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/15/25.
//

import SwiftUI

struct ActionView: View {
    let icon: String
    let action: String
    let isCorrect: Bool

    var body: some View {
        HStack {
            Text(icon)
            Text(action)
        }
        .padding()
        .frame(width: 150)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isCorrect ? Color.green.opacity(0.7) : Color.gray.opacity(0.05))
        )
    }
}
struct HorizontalGauge: View {
    let value: Double // 0.0 to 1.0
    
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
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(height: 10)
                    .foregroundColor(.gray.opacity(0.1))

                Capsule()
                    .frame(width: geometry.size.width * value, height: 10)
                    .foregroundColor(fillColor)
            }
        }
        .frame(width: 100, height: 10)
    }
}

struct AnalyzeView: View {
    @Binding var showPopover: Bool
    @Binding var modelResponse: [String]?
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                Spacer().frame(height: 40)
                ActionView(icon: "✋", action: "Check", isCorrect: modelResponse![0] == "Check")
                ActionView(icon: "💰", action: "Bet", isCorrect: modelResponse![0] == "Bet")
                ActionView(icon: "🗑️", action: "Fold", isCorrect: modelResponse![0] == "Fold")
                Spacer().frame(height: 40)
                HStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Villain's range")
                        Text("Hero's range")
                    }
                    VStack(spacing: 16) {
                        HorizontalGauge(value: Double(modelResponse![1].trimmingCharacters(in: .whitespacesAndNewlines))!)
                        HorizontalGauge(value: Double(modelResponse![2].trimmingCharacters(in: .whitespacesAndNewlines))!)
                    }
                }
                Spacer().frame(height: 40)
                if let modelResponse {
                    MarkdownView(markdownString: modelResponse[3].trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundStyle(Color.gray.opacity(0.05))
                        )
                }
            }
            Button("Close") {
                showPopover = false
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
