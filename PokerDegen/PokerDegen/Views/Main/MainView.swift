//
//  MainView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

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
    
    private func action() {
        let hostingController = UIHostingController(rootView: CardSelector(navigationController: navigationController))
        hostingController.modalPresentationStyle = .overCurrentContext
        hostingController.view.backgroundColor = .clear
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.present(hostingController, animated: true)
    }

    var body: some View {
        VStack {
            ZStack {
                PokerTable()
                VStack {
                    HStack(spacing: -29.0) {
                        Button(action: {
                            action()
                        }) {
                            Image("card")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(-9))
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("card")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(9))
                        }
                    }
                    Spacer().frame(height: 350)
                }
                VStack {
                    Spacer().frame(height: 20)
                    HStack(spacing: -10.0) {
                        Button(action: {
                            action()
                        }) {
                            Image("2c")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("td")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("jd")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("4s")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 56, height: 56)
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("qd")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                        }
                    }
                }
                VStack {
                    Spacer().frame(height: 470)
                    HStack(spacing: -29.0) {
                        Button(action: {
                            action()
                        }) {
                            Image("ad")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(-9))
                        }
                        Button(action: {
                            action()
                        }) {
                            Image("kd")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .rotationEffect(.degrees(9))
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MainView(navigationController: UINavigationController())
}
