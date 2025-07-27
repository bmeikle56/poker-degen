//
//  DeleteAccountView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/27/25.
//

import SwiftUI

struct DeleteAccountView: View {
    let navigationController: UINavigationController

    @ObservedObject var authViewModel = AuthViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: {
                        if let topVC = UIApplication.topViewController() {
                            topVC.dismiss(animated: true)
                        }
                    }, label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("Cancel")
                        }
                        .foregroundStyle(Color.pdBlue)
                    })
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
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
                DeleteAccountButton(
                    navigationController: navigationController,
                    authViewModel: authViewModel,
                )
                Spacer().frame(height: 20)
            }
        }
    }
}

#Preview {
    DeleteAccountView(
        navigationController: UINavigationController(),
    )
}
