//
//  MainView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI
import Combine

struct BoardData: Codable {
    let board: CardData
}

struct CardData: Codable {
    let cc1, cc2, cc3, cc4, cc5: String
    let hc1, hc2: String
    let v1c1, v1c2: String
    let pot: String
    let vpt, vp, hp: String
}

class CardViewModel: ObservableObject {
    /// cc4 = Community Card 4 (the turn)
    @Published var cc1: String = "card"
    @Published var cc2: String = "card"
    @Published var cc3: String = "card"
    @Published var cc4: String = "card"
    @Published var cc5: String = "card"
    
    /// hc1 = Hero Card 1
    @Published var hc1: String = "card"
    @Published var hc2: String = "card"
    
    /// v1c2 = Villian 1 Card 2
    @Published var v1c1: String = "card"
    @Published var v1c2: String = "card"
    
    /// vfb = Villain Flop Bet
    @Published var vfb: Int = 0
    
    /// hfb = Hero Flop Bet
    @Published var hfb: Int = 0
    
    /// vpt = Villain Player Type
    @Published var vpt: String = "Player Type"
    
    /// vp = Villain Position
    @Published var vp: String = "Position"
    
    /// hp = Hero Position
    @Published var hp: String = "Position"
    
    var boardData: BoardData {
        BoardData(board: CardData(cc1: cc1, cc2: cc2, cc3: cc3, cc4: cc4, cc5: cc5, hc1: hc1, hc2: hc2, v1c1: v1c1, v1c2: v1c2, pot: String(Int(vfb+hfba)), vpt: vpt, vp: vp, hp: hp))
    }
}

struct CardImage: View {
    let name: String

    var resolvedName: String {
        
        /// we are in the middle of selecting an empty card, and don't want to render
        /// an image too early
        if name.hasPrefix("_") {
            return "card"
        } else {
            return name
        }
    }

    var body: some View {
        Image(resolvedName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct PokerTable: View {
    var body: some View {
        GeometryReader { geo in
            let scale: CGFloat = 0.75
            let width = geo.size.width * scale
            let height = geo.size.height

            ZStack {
                // Diamond overlay texture
                Capsule()
                    .overlay(
                        DiamondPattern()
                            .clipShape(Capsule())
                            .rotation3DEffect(
                                .degrees(50),
                                axis: (x: 1, y: 0, z: 0),
                                perspective: 0.5
                            )
                    )

                // Maroon border
                Capsule()
                    .stroke(Color.pokerMaroon, lineWidth: 8)
                    .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 0), perspective: 0.5)
            }
            .frame(width: width, height: height)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(radius: 10)
        }
        .aspectRatio(0.6, contentMode: .fit)
        .padding()
        .offset(y: CGFloat(-10))
    }
}

struct DiamondPattern: View {
    var body: some View {
        GeometryReader { geo in
            let spacing: CGFloat = 30
            let columns = Int(geo.size.width / spacing) + 2
            let rows = Int(geo.size.height / spacing) + 2

            let color1 = Color.green.opacity(0.1)
            let color2 = Color.green.opacity(0.1)

            ZStack {
                Color.green.opacity(0.3)
                ForEach(0..<columns, id: \.self) { i in
                    ForEach(0..<rows, id: \.self) { j in
                        DiamondShape()
                            .fill((i + j).isMultiple(of: 2) ? color1 : color2)
                            .frame(width: spacing, height: spacing)
                            .position(
                                x: CGFloat(i) * spacing,
                                y: CGFloat(j) * spacing
                            )
                        
                    }
                }
            }
        }
    }
}

struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let centerX = rect.midX
        let centerY = rect.midY

        path.move(to: CGPoint(x: centerX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: centerY))
        path.addLine(to: CGPoint(x: centerX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: centerY))
        path.closeSubpath()

        return path
    }
}

struct CardView: View {
    let onTap: (Binding<String>) -> Void
    var width: CGFloat = 80
    var height: CGFloat = 80
    var rotation: Double = 0

    @Binding var card: String
    
    @State private var tapCount = 0

    var body: some View {
        CardImage(name: card)
            .scaledToFit()
            .frame(width: width, height: height)
            .rotationEffect(.degrees(rotation))
            .onTapGesture {
                tapCount += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if tapCount == 1 {
                        onTap($card)
                    } else if tapCount == 2 {
                        card = "card"
                    }
                    tapCount = 0
                }
            }
    }
}

struct VillainCardView: View {
    let navigationController: UINavigationController
    
    @ObservedObject var viewModel: CardViewModel

    private func select(card: Binding<String>) {
        let hostingController = UIHostingController(rootView: CardSelector(
            navigationController: navigationController,
            card: card
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            HStack(spacing: -29.0) {
                CardView(
                    onTap: select,
                    rotation: -9,
                    card: $viewModel.v1c1
                )
                CardView(
                    onTap: select,
                    rotation: 9,
                    card: $viewModel.v1c2
                )
            }
            Spacer().frame(height: 350)
        }
    }
}

struct CommunityCardView: View {
    let navigationController: UINavigationController
    
    @ObservedObject var viewModel: CardViewModel

    private func select(card: Binding<String>) {
        let hostingController = UIHostingController(rootView: CardSelector(
            navigationController: navigationController,
            card: card
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            HStack(spacing: -12.0) {
                CardView(
                    onTap: select,
                    width: 65,
                    height: 65,
                    card: $viewModel.cc1
                )
                CardView(
                    onTap: select,
                    width: 65,
                    height: 65,
                    card: $viewModel.cc2
                )
                CardView(
                    onTap: select,
                    width: 65,
                    height: 65,
                    card: $viewModel.cc3
                )
                CardView(
                    onTap: select,
                    width: 65,
                    height: 65,
                    card: $viewModel.cc4
                )
                CardView(
                    onTap: select,
                    width: 65,
                    height: 65,
                    card: $viewModel.cc5
                )
            }
        }
    }
}

func chipBreakdown(for bet: Int) -> [(Int, Int)] {
    let denominations = [500, 100, 50, 25, 10, 1]
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

struct HeroCardView: View {
    let navigationController: UINavigationController
    
    @ObservedObject var viewModel: CardViewModel

    private func select(card: Binding<String>) {
        let hostingController = UIHostingController(rootView: CardSelector(
            navigationController: navigationController,
            card: card
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            HStack(spacing: -29.0) {
                CardView(
                    onTap: select,
                    rotation: -9,
                    card: $viewModel.hc1
                )
                CardView(
                    onTap: select,
                    rotation: 9,
                    card: $viewModel.hc2
                )
            }
            .offset(y: CGFloat(220))
        }
    }
}

struct AnalyzeButtonView: View {
    @Binding var showPopover: Bool
    @Binding var modelResponse: [String]?
    @ObservedObject var viewModel: CardViewModel

    var body: some View {
        VStack {
            Button(action: {
                Task {
                    modelResponse = nil
                    modelResponse = try await analyze(viewModel: viewModel)
                }
            }, label: {
                HStack {
                    Text("1")
                        .foregroundStyle(Color.pdBlue)
                    DiamondOutline()
                        .fill(Color.pdBlue)
                        .frame(width: 12, height: 24)
                    Spacer().frame(width: 12)
                    Text("Analyze")
                        .foregroundStyle(Color.pdBlue)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.pdBlue, lineWidth: 2)
                )
            })
            .onChange(of: modelResponse, { _, _ in
                showPopover = true
            })
            .offset(y: CGFloat(380))
        }
    }
}

struct DiamondBalanceView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    DiamondOutline()
                        .fill(Color.pdBlue)
                        .frame(width: 12, height: 24)
                    Button(action: {
                        // nothing for now
                    }, label: {
                        Text("+")
                            .foregroundStyle(Color.pdBlue)
                            .font(.system(size: 24, weight: .heavy, design: .default))
                            .padding(.horizontal, 4)
                            .padding(.top, -4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.pdBlue, lineWidth: 2)
                            )
                    })
                }
                .padding(50)
            }
            .padding(.vertical, 50)
            Spacer()
        }
    }
}

struct StackedChipsView: View {
    let count: Int
    let type: String

    var body: some View {
        ZStack {
            ForEach(0..<count, id: \.self) { index in
                let reverseIndex = 2 - index
                Image(type)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .offset(y: CGFloat(index) * -8)
                    .rotation3DEffect(
                        .degrees(50),
                        axis: (x: 1, y: 0, z: 0),
                        perspective: 0.5
                    )
                    .scaleEffect(1.0 - CGFloat(reverseIndex) * 0.09)
            }
        }
    }
}

struct VillainStackedChipsView: View {
    let navigationController: UINavigationController

    @ObservedObject var viewModel: CardViewModel
    
    private func selectVillainBet() {
        let hostingController = UIHostingController(rootView: BetSelector(
            navigationController: navigationController,
            bet: $viewModel.vfb
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Button(action: {
                selectVillainBet()
            }, label: {
                betUI(for: viewModel.vfb)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
            })
        }
        .offset(y: CGFloat(-90))
    }
}

struct HeroStackedChipsView: View {
    let navigationController: UINavigationController

    @ObservedObject var viewModel: CardViewModel
    
    private func selectHeroBet() {
        let hostingController = UIHostingController(rootView: BetSelector(
            navigationController: navigationController,
            bet: $viewModel.hfb
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Button(action: {
                selectHeroBet()
            }, label: {
                betUI(for: viewModel.hfb)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
            })
        }
        .offset(y: CGFloat(135))
    }
}

struct HeroPositionView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: CardViewModel
    
    private func selectHeroPosition() {
        let hostingController = UIHostingController(rootView: PositionSelector(
            navigationController: navigationController,
            selectedPosition: $viewModel.hp
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Button(action: {
                selectHeroPosition()
            }, label: {
                Text(viewModel.hp)
                    .foregroundStyle(Color.white)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
                
            })
            .offset(y: CGFloat(300))
        }
    }
}

struct VillainPositionView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: CardViewModel
    
    private func selectVillainPosition() {
        let hostingController = UIHostingController(rootView: PositionSelector(
            navigationController: navigationController,
            selectedPosition: $viewModel.vp
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Button(action: {
                selectVillainPosition()
            }, label: {
                Text(viewModel.vp)
                    .foregroundStyle(Color.white)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
            })
            .offset(x: CGFloat(55), y: CGFloat(-260))
        }
    }
}

struct VillainPlayerTypeView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: CardViewModel
    
    private func selectVillainPlayerType() {
        let hostingController = UIHostingController(rootView: PlayerTypeSelector(
            navigationController: navigationController,
            selectedPlayerType: $viewModel.vpt
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            Button(action: {
                selectVillainPlayerType()
            }, label: {
                Text(viewModel.vpt)
                    .foregroundStyle(Color.white)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
                
            })
            .offset(x: CGFloat(-60), y: CGFloat(-260))
        }
    }
}

struct MainView: View {
    let navigationController: UINavigationController
    
    private func select(card: Binding<String>) {
        let hostingController = UIHostingController(rootView: CardSelector(
            navigationController: navigationController,
            card: card
        ))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }
    
    @State private var showPopover = false
    @State private var modelResponse: [String]?
    @StateObject private var viewModel = CardViewModel()

    var body: some View {
        VStack {
            ZStack {
                DiamondBalanceView()
                PokerTable()
                VillainPlayerTypeView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                VillainPositionView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                VillainCardView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                VillainStackedChipsView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                CommunityCardView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                HeroStackedChipsView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                HeroCardView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                HeroPositionView(
                    navigationController: navigationController,
                    viewModel: viewModel
                )
                AnalyzeButtonView(
                    showPopover: $showPopover,
                    modelResponse: $modelResponse,
                    viewModel: viewModel
                )
            }
            .popover(isPresented: $showPopover) {
                AnalyzeView(
                    showPopover: $showPopover,
                    modelResponse: $modelResponse
                )
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct MarkdownView: View {
    let markdownString: String

    var body: some View {
        if let attributed = try? AttributedString(markdown: markdownString) {
            Text(attributed)
                .padding()
        } else {
            Text(markdownString)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    MainView(navigationController: UINavigationController())
}
