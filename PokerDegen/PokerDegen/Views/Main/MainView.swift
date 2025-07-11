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
}

class CardViewModel: ObservableObject {
    /// cc4 = Community Card 4 (the turn)
    @Published var cc1: String = "card"
    @Published var cc2: String = "card"
    @Published var cc3: String = "card"
    @Published var cc4: String = "card"
    @Published var cc5: String = "card"
    
    /// hc1 = Hero Card 1
    @Published var hc1: String = "4s"
    @Published var hc2: String = "5s"
    
    /// v1c2 = Villian 1 Card 2
    @Published var v1c1: String = "ac"
    @Published var v1c2: String = "qd"
    
    var boardData: BoardData {
        BoardData(board: CardData(cc1: cc1, cc2: cc2, cc3: cc3, cc4: cc4, cc5: cc5, hc1: hc1, hc2: hc2, v1c1: v1c1, v1c2: v1c2))
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
                Capsule()
                    .fill(Color.green.opacity(0.3))
                    .rotation3DEffect(
                            .degrees(50),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )
                Capsule()
                    .stroke(Color.pokerMaroon, lineWidth: 6)
                    .rotation3DEffect(
                            .degrees(50),
                            axis: (x: 1, y: 0, z: 0),
                            perspective: 0.5
                        )
            }
            .frame(width: width, height: height)
            .position(x: geo.size.width / 2, y: geo.size.height / 2)
            .shadow(radius: 10)
        }
        .aspectRatio(0.6, contentMode: .fit)
        .padding()
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
    @State private var modelResponse: String?
    @StateObject private var viewModel = CardViewModel()

    var body: some View {
        VStack {
            ZStack {
                PokerTable()
                VStack {
                    HStack(spacing: -29.0) {
                        Button(action: {
                            select(card: $viewModel.v1c1)
                        }) {
                            CardImage(name: viewModel.v1c1)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(-9))
                        }
                        .onLongPressGesture() {
                            viewModel.v1c1 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.v1c2)
                        }) {
                            CardImage(name: viewModel.v1c2)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(9))
                        }
                        .onLongPressGesture() {
                            viewModel.v1c2 = "card"
                        }
                    }
                    Spacer().frame(height: 350)
                }
                VStack {
                    Spacer().frame(height: 20)
                    HStack(spacing: -10.0) {
                        Button(action: {
                            select(card: $viewModel.cc1)
                        }) {
                            CardImage(name: viewModel.cc1)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .onLongPressGesture() {
                            viewModel.cc1 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.cc2)
                        }) {
                            CardImage(name: viewModel.cc2)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .onLongPressGesture() {
                            viewModel.cc2 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.cc3)
                        }) {
                            CardImage(name: viewModel.cc3)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .onLongPressGesture() {
                            viewModel.cc3 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.cc4)
                        }) {
                            CardImage(name: viewModel.cc4)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .onLongPressGesture() {
                            viewModel.cc4 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.cc5)
                        }) {
                            CardImage(name: viewModel.cc5)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        }
                        .onLongPressGesture() {
                            viewModel.cc5 = "card"
                        }
                    }
                }
                VStack {
                    Spacer().frame(height: 470)
                    HStack(spacing: -29.0) {
                        Button(action: {
                            select(card: $viewModel.hc1)
                        }) {
                            CardImage(name: viewModel.hc1)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(-9))
                        }
                        .onLongPressGesture() {
                            viewModel.hc1 = "card"
                        }
                        Button(action: {
                            select(card: $viewModel.hc2)
                        }) {
                            CardImage(name: viewModel.hc2)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(9))
                        }
                        .onLongPressGesture() {
                            viewModel.hc2 = "card"
                        }
                    }
                }
                VStack {
                    Spacer().frame(height: 700)
                    Button(action: {
                        print("showPopover: \(showPopover)")
                        Task {
                            modelResponse = nil
                            modelResponse = try await analyze(viewModel: viewModel)
                        }
                    }, label: {
                        Text("Analyze")
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                            )
                    })
                    .onChange(of: modelResponse, { _, _ in
                        showPopover = true
                    })
                }
                VStack {
                    Spacer().frame(height: 330)
                    HStack {
                        Spacer().frame(width: 80)
                        Image("chips")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
                VStack {
                    HStack {
                        Image("chips")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Spacer().frame(width: 80)
                    }
                    Spacer().frame(height: 210)
                }
            }
            .popover(isPresented: $showPopover) {
                VStack(spacing: 16) {
                    ScrollView {
                        if let modelResponse {
                            MarkdownView(markdownString: modelResponse)
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundStyle(Color.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
