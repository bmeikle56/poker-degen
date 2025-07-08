//
//  ContentView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct UsernameField: View {
    let placeholder: String
    @State private var username: String = ""
    
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
    @State private var password: String = ""
    
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

    var body: some View {
        Button(action: {
            navigationController.pushViewController(
                UIHostingController(rootView:
                                        LoginView(navigationController: navigationController)
                                   ), animated: true
            )
        }, label: {
            Text("Login")
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding()
                .frame(width: 250)
                .background(Color.pdBlue)
                .cornerRadius(8)
        })
    }
}

struct LoginView: View {
    let navigationController: UINavigationController

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
            UsernameField(placeholder: "Username")
            Spacer().frame(height: 20)
            PasswordField(placeholder: "Password")
            Spacer().frame(height: 20)
            LoginButton(navigationController: navigationController)
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    LoginView(navigationController: UINavigationController())
}
