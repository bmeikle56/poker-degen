//
//  SignupView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/13/25.
//

import SwiftUI

struct SignupView: View {
    let navigationController: UINavigationController
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isAuthorized: Bool?

    var body: some View {
        VStack {
            PokerDegenTitleView()
            Spacer().frame(height: 40)
            AuthErrorMessageView(
                message: "Enter a valid username and password",
                isAuthorized: $isAuthorized
            )
            Spacer().frame(height: 20)
            UsernameField(placeholder: "Username", username: $username)
            Spacer().frame(height: 20)
            PasswordField(placeholder: "Password", password: $password)
            Spacer().frame(height: 20)
            AuthButton(
                navigationController: navigationController,
                text: "Signup",
                auth: signup,
                username: $username,
                password: $password,
                isAuthorized: $isAuthorized
            )
            Spacer().frame(height: 20)
            Button(action: {
                navigationController.pushViewController(
                    UIHostingController(rootView: LoginView(navigationController: navigationController)),
                    animated: false
                )
            }, label: {
                Text("Have an account? **Login**")
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
    SignupView(
        navigationController: UINavigationController(),
        username: "username",
        password: "password",
    )
}
