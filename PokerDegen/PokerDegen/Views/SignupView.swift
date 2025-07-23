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
        VStack {
            PokerDegenTitleView()
            Spacer().frame(height: 20)
            AuthErrorMessageView(
                message: "Enter a valid username and password",
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
                navigationController.popToRootViewController(animated: false)
            }, label: {
                Text("Have an account? **Login**")
                    .foregroundStyle(Color.pdBlue)
            })
            Spacer().frame(height: 150)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    SignupView(
        navigationController: UINavigationController(),
        authViewModel: AuthViewModel()
    )
}
