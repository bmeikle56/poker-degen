//
//  ContentView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isAuthorized: Bool?

    var body: some View {
        if let isAuthorized, isAuthorized == false {
            Text("Incorrect username or password")
                .foregroundStyle(Color.red)
        } else {
            Spacer().frame(height: 20)
        }
    }
}

struct UsernameField: View {
    let placeholder: String
    
    @Binding var username: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if username.isEmpty {
                Text("Username")
                    .foregroundColor(.smoothGray)
                    .padding(.horizontal, 16)
            }

            TextField("", text: $username)
                .padding()
                .frame(width: 250)
                .autocapitalization(.none)
                .foregroundStyle(Color.smoothGray)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 1.4))
                        .foregroundStyle(Color.pdBlue)
                )
        }
    }
}

struct PasswordField: View {
    let placeholder: String
    
    @Binding var password: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if password.isEmpty {
                Text("Password")
                    .foregroundColor(.smoothGray)
                    .padding(.horizontal, 16)
            }

            SecureField("", text: $password)
                .padding()
                .frame(width: 250)
                .foregroundStyle(Color.smoothGray)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(style: StrokeStyle(lineWidth: 1.4))
                        .foregroundStyle(Color.pdBlue)
                )
        }
    }
}

struct LoginButton: View {
    let navigationController: UINavigationController
    
    @Binding var username: String
    @Binding var password: String
    @Binding var isAuthorized: Bool?

    var body: some View {
        Button(action: {
            Task {
                isAuthorized = await login(username: username, password: password)
            }
        }, label: {
            Text("Login")
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding()
                .frame(width: 250)
                .background(Color.pdBlue)
                .cornerRadius(8)
        })
        .onChange(of: isAuthorized, { _, _ in
            if let isAuthorized, isAuthorized == true {
                navigationController.pushViewController(
                    UIHostingController(rootView:
                                            MainView(navigationController: navigationController)
                                       ), animated: true)
            }
        })
    }
}

struct LoginView: View {
    let navigationController: UINavigationController
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isAuthorized: Bool?

    var body: some View {
        VStack {
            HStack {
                DiamondShape()
                    .stroke(Color.pdBlue, lineWidth: 4)
                    .frame(width: 20, height: 40)
                Spacer().frame(width: 20)
                Text("PokerDegen")
                    .foregroundStyle(Color.pdBlue)
                    .font(.system(size: 34, weight: .bold, design: .default))
            }
            Spacer().frame(height: 40)
            ErrorView(isAuthorized: $isAuthorized)
            Spacer().frame(height: 20)
            UsernameField(placeholder: "Username", username: $username)
            Spacer().frame(height: 20)
            PasswordField(placeholder: "Password", password: $password)
            Spacer().frame(height: 20)
            LoginButton(navigationController: navigationController, username: $username, password: $password, isAuthorized: $isAuthorized)
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
