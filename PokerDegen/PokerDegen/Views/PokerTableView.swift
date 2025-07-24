//
//  PokerTableView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

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
            let scale: CGFloat = 0.80
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
                    .stroke(Color.pokerMaroon, lineWidth: 4)
                    .rotation3DEffect(.degrees(50), axis: (x: 1, y: 0, z: 0), perspective: 0.5)
            }
            .frame(width: width, height: height)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(radius: 10)
        }
        .aspectRatio(0.6, contentMode: .fit)
        .padding()
        .offset(y: CGFloat(-20))
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
    
    @ObservedObject var viewModel: HandViewModel

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
            Spacer().frame(height: 365)
        }
    }
}

struct CommunityCardView: View {
    let navigationController: UINavigationController
    
    @ObservedObject var viewModel: HandViewModel

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
            Spacer().frame(height: 10)
            HStack(spacing: -14.0) {
                CardView(
                    onTap: select,
                    width: 70,
                    height: 70,
                    card: $viewModel.cc1
                )
                CardView(
                    onTap: select,
                    width: 70,
                    height: 70,
                    card: $viewModel.cc2
                )
                CardView(
                    onTap: select,
                    width: 70,
                    height: 70,
                    card: $viewModel.cc3
                )
                CardView(
                    onTap: select,
                    width: 70,
                    height: 70,
                    card: $viewModel.cc4
                )
                CardView(
                    onTap: select,
                    width: 70,
                    height: 80,
                    card: $viewModel.cc5
                )
            }
        }
    }
}

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

struct HeroCardView: View {
    let navigationController: UINavigationController
    
    @ObservedObject var viewModel: HandViewModel

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
            .offset(y: CGFloat(210))
        }
    }
}

struct AnalyzeButtonView: View {
    @Binding var showPopover: Bool
    @Binding var modelResponse: [String]?
    @ObservedObject var viewModel: HandViewModel

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
                    Diamond()
                        .fill(Color.pdBlue)
                        .frame(width: 12, height: (820/468)*12)
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
            .offset(y: CGFloat(360))
        }
    }
}

struct DiamondBalanceView: View {
    let navigationController: UINavigationController

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Diamond()
                        .fill(Color.pdBlue)
                        .frame(width: 12, height: (820/468)*12)
                    Button(action: {
                        let hostingController = UIHostingController(rootView: PaymentView(
                            navigationController: navigationController,
                        ))
                        hostingController.modalPresentationStyle = .overFullScreen
                        hostingController.view.backgroundColor = .clear
                        navigationController.modalPresentationStyle = .overFullScreen
                        navigationController.present(hostingController, animated: true)
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
            .padding(.vertical, 35)
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

    @ObservedObject var viewModel: HandViewModel
    
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
        .offset(y: CGFloat(-100))
    }
}

struct HeroStackedChipsView: View {
    let navigationController: UINavigationController

    @ObservedObject var viewModel: HandViewModel
    
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
        .offset(y: CGFloat(125))
    }
}

struct HeroPositionView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: HandViewModel
    
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
            .offset(y: CGFloat(290))
        }
    }
}

struct VillainPositionView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: HandViewModel
    
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
            .offset(x: CGFloat(55), y: CGFloat(-270))
        }
    }
}

struct VillainPlayerTypeView: View {
    let navigationController: UINavigationController
    @ObservedObject var viewModel: HandViewModel
    
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
            .offset(x: CGFloat(-60), y: CGFloat(-270))
        }
    }
}

struct HelpButtonView: View {
    let navigationController: UINavigationController
    @State private var showHelp = false

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        let hostingController = UIHostingController(rootView: HelpView(
                            navigationController: navigationController
                        ))
                        hostingController.modalPresentationStyle = .overFullScreen
                        hostingController.view.backgroundColor = .clear
                        navigationController.modalPresentationStyle = .overFullScreen
                        navigationController.present(hostingController, animated: true)
                    }) {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundStyle(Color.pdBlue)
                    }
                    .padding(.horizontal, 35)
                }
                .padding(50)
                Spacer()
            }
            .padding(.vertical, 35)
            Spacer()
        }
    }
}

struct PokerTableView: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel
    
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
    @StateObject private var viewModel = HandViewModel()

    var body: some View {
        VStack {
            ZStack {
                DiamondBalanceView(
                    navigationController: navigationController
                )
                SettingsButtonView(
                    navigationController: navigationController,
                    authViewModel: authViewModel
                )
                HelpButtonView(
                    navigationController: navigationController
                )
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

struct SettingsButtonView: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        let hostingController = UIHostingController(rootView: SettingsView(
                            navigationController: navigationController,
                            authViewModel: authViewModel
                        ))
                        hostingController.modalPresentationStyle = .overFullScreen
                        hostingController.view.backgroundColor = .clear
                        navigationController.modalPresentationStyle = .overFullScreen
                        navigationController.present(hostingController, animated: true)
                    }) {
                        Image(systemName: "gear")
                            .font(.title2)
                            .foregroundStyle(Color.pdBlue)
                    }
                }
                .padding(50)
                Spacer()
            }
            .padding(.vertical, 35)
            Spacer()
        }
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
    PokerTableView(
        navigationController: UINavigationController(),
        authViewModel: AuthViewModel()
    )
}
