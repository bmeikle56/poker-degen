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
            VStack(spacing: layout.spacing) {
                PokerDegenTitleView(
                    scale: layout.titleScale
                )
                AuthErrorMessageView(
                    authViewModel: authViewModel
                )
                UsernameField(
                    placeholder: "Username",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                PasswordField(
                    placeholder: "Password",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                SignupButton(
                    navigationController: navigationController,
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel
                )
                Button(action: {
                    authViewModel.errorMessage = nil
                    navigationController.popToRootViewController(animated: false)
                }, label: {
                    Text("Have an account? **Login**")
                        .foregroundStyle(Color.pdBlue)
                        .font(.system(size: layout.fontSize))
                })
            }
        }
        .navigationBarHidden(true)
    }
}

/// iPhone
#Preview("iPhone") {
    SignupView(
        navigationController: UINavigationController(),
        layout: Layout.signupView[.iPhone]!,
        authViewModel: AuthViewModel()
    )
}

/// iPad
#Preview("iPad") {
    SignupView(
        navigationController: UINavigationController(),
        layout: Layout.signupView[.iPad]!,
        authViewModel: AuthViewModel()
    )
}
