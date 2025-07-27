//
//  SignupView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/13/25.
//

import SwiftUI

struct SignupView: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                PokerDegenTitleView()
                Spacer().frame(height: 20)
                AuthErrorMessageView(
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                UsernameField(
                    placeholder: "Username",
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                PasswordField(
                    placeholder: "Password",
                    authViewModel: authViewModel
                )
                Spacer().frame(height: 20)
                SignupButton(
                    navigationController: navigationController,
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

#Preview {
    SignupView(
        navigationController: UINavigationController(),
        authViewModel: AuthViewModel()
    )
}
