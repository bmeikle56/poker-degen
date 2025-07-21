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

    var body: some View {
        VStack {
            PokerDegenTitleView()
            Spacer().frame(height: 40)
            AuthErrorMessageView(
                message: "Incorrect username or password", 
                isAuthorized: $isAuthorized
            )
            Spacer().frame(height: 20)
            UsernameField(placeholder: "Username", username: $username)
            Spacer().frame(height: 20)
            PasswordField(placeholder: "Password", password: $password)
            Spacer().frame(height: 20)
            AuthButton(
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
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(
        navigationController: UINavigationController(),
        username: "username",
        password: "password",
    )
}
