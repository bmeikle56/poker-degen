//
//  SignupView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/13/25.
//

import SwiftUI

struct SignupViewLayout {
    let titleScale: CGFloat
    let spacing: CGFloat
    let fontSize: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
}

struct SignupView: View {
    let navigationController: UINavigationController
    let layout: SignupViewLayout
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                PokerDegenTitleView(
                    scale: layout.titleScale
                )
                Spacer().frame(height: 20)
                AuthErrorMessageView(
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                UsernameField(
                    placeholder: "Username",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                PasswordField(
                    placeholder: "Password",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                SignupButton(
                    navigationController: navigationController,
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                Button(action: {
                    authViewModel.errorMessage = nil
                    navigationController.popToRootViewController(animated: false)
                }, label: {
                    Text("Have an account? **Login**")
                        .foregroundStyle(Color.pdBlue)
                })
                Spacer().frame(height: 20)
            }
        }
        .navigationBarHidden(true)
    }
}

/// iPhone
#Preview("iPhone") {
    SignupView(
        navigationController: UINavigationController(),
        layout: SignupViewLayout(
            titleScale: 16,
            spacing: 30,
            fontSize: 16,
            buttonWidth: 150,
            buttonHeight: 60,
        ),
        authViewModel: AuthViewModel()
    )
}

/// iPad
#Preview("iPad") {
    SignupView(
        navigationController: UINavigationController(),
        layout: SignupViewLayout(
            titleScale: 30,
            spacing: 30,
            fontSize: 16,
            buttonWidth: 150,
            buttonHeight: 60,
        ),
        authViewModel: AuthViewModel()
    )
}
