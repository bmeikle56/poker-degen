//
//  LoginView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct LoginView: View {
    let navigationController: UINavigationController
    
    @State private var showFaceIDPrompt = false
    
    @ObservedObject var authViewModel = AuthViewModel()

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
                LoginButton(
                    navigationController: navigationController,
                    authViewModel: authViewModel,
                )
                Spacer().frame(height: 20)
                Button(action: {
                    authViewModel.errorMessage = nil
                    navigationController.pushViewController(
                        UIHostingController(rootView: SignupView(
                            navigationController: navigationController,
                            authViewModel: authViewModel
                        )),
                        animated: false
                    )
                }, label: {
                    Text("Create an account")
                        .foregroundStyle(Color.pdBlue)
                })
                Spacer().frame(height: 20)
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

#Preview {
    LoginView(
        navigationController: UINavigationController(),
    )
}
