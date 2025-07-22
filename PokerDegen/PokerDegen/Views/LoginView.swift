//
//  LoginView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct LoginView: View {
    let navigationController: UINavigationController
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isAuthorized: Bool?
    @State private var showFaceIDPrompt = false

    var body: some View {
        VStack {
            PokerDegenTitleView()
            Spacer().frame(height: 20)
            AuthErrorMessageView(
                message: "Incorrect username or password", 
                isAuthorized: $isAuthorized
            )
            Spacer().frame(height: 20)
            UsernameField(placeholder: "Username", username: $username)
            Spacer().frame(height: 20)
            PasswordField(placeholder: "Password", password: $password)
            Spacer().frame(height: 20)
            LoginButton(
                navigationController: navigationController,
                text: "Login",
                auth: login,
                username: $username,
                password: $password,
                isAuthorized: $isAuthorized
            )
            Spacer().frame(height: 20)
            Button(action: {
                navigationController.pushViewController(
                    UIHostingController(rootView: SignupView(navigationController: navigationController)),
                    animated: false
                )
            }, label: {
                Text("Create an account")
                    .foregroundStyle(Color.pdBlue)
            })
            Spacer().frame(height: 150)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
        .task {
            /// prompt FaceID on appear if enabled
            guard let useBiometrics = UserDefaults.standard.value(forKey: "biometrics") as? Bool,
                  useBiometrics == true else {
                return
            }
            Task { @MainActor in
                isAuthorized = try? await authenticateWithFaceID()
            }
        }
        .onChange(of: isAuthorized, {
            if let isAuthorized, isAuthorized == true {
                navigationController.pushViewController(
                    UIHostingController(rootView: PokerTableView(navigationController: navigationController)),
                    animated: false
                )
            }
        })
    }
}

#Preview {
    LoginView(
        navigationController: UINavigationController(),
        username: "Username",
        password: "Password",
    )
}
