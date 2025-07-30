//
//  LoginView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct LoginViewLayout {
    let titleScale: CGFloat
    let spacing: CGFloat
    let fontSize: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
}

struct LoginView: View {
    let navigationController: UINavigationController
    let layout: LoginViewLayout
    
    @State private var showFaceIDPrompt = false
    
    @ObservedObject var authViewModel = AuthViewModel()

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
                LoginButton(
                    navigationController: navigationController,
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight,
                    authViewModel: authViewModel,
                )
                Button(action: {
                    authViewModel.errorMessage = nil
                    navigationController.pushViewController(
                        UIHostingController(rootView: SignupView(
                            navigationController: navigationController, layout: Layout.signupView[.iPhone]!,
                            authViewModel: authViewModel
                        )),
                        animated: false
                    )
                }, label: {
                    Text("Create an account")
                        .foregroundStyle(Color.pdBlue)
                        .font(.system(size: layout.fontSize))
                })
            }
            .task {
                authViewModel.username = ""
                authViewModel.password = ""
                
                /// prompt FaceID on appear if enabled and username + password stored
                guard let useBiometrics = UserDefaults.standard.value(forKey: "biometrics") as? Bool,
                      useBiometrics == true,
                      let _ = UserDefaults.standard.string(forKey: "username"),
                      let _ = UserDefaults.standard.string(forKey: "password") else {
                    return
                }
                authViewModel.loginUserWithFaceID()
            }
            .onChange(of: authViewModel.authorized, {
                if let authorized = authViewModel.authorized, authorized == true {
                    navigationController.pushViewController(
                        UIHostingController(rootView: PokerTableView(
                            navigationController: navigationController,
                            layout: Layout.pokerTableView[.iPhone]!,
                            authViewModel: authViewModel
                        )),
                        animated: false
                    )
                }
            })
        }
    }
}

/// iPhone
#Preview("iPhone") {
    LoginView(
        navigationController: UINavigationController(),
        layout: Layout.loginView[.iPhone]!,
        authViewModel: AuthViewModel()
    )
}

/// iPad
#Preview("iPad") {
    LoginView(
        navigationController: UINavigationController(),
        layout: Layout.loginView[.iPad]!,
        authViewModel: AuthViewModel()
    )
}
