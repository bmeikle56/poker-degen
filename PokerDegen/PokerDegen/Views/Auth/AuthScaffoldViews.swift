//
//  AuthScaffoldViews.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/13/25.
//

import SwiftUI

struct PokerDegenTitleView: View {
    var body: some View {
        HStack {
            DiamondShape()
                .stroke(Color.pdBlue, lineWidth: 4)
                .frame(width: 20, height: 40)
            Spacer().frame(width: 20)
            Text("PokerDegen")
                .foregroundStyle(Color.pdBlue)
                .font(.system(size: 34, weight: .bold, design: .default))
        }
    }
}

struct AuthErrorMessageView: View {
    let message: String

    @Binding var isAuthorized: Bool?

    var body: some View {
        if let isAuthorized, isAuthorized == false {
            Text(message)
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

struct AuthButton: View {
    let navigationController: UINavigationController
    let text: String
    let action: () -> Void
    
    @Binding var username: String
    @Binding var password: String
    @Binding var isAuthorized: Bool?

    var body: some View {
        Button(action: {
            Task {
                isAuthorized = await login(username: username, password: password)
            }
        }, label: {
            Text(text)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding()
                .frame(width: 250)
                .background(Color.pdBlue)
                .cornerRadius(8)
        })
        .onChange(of: isAuthorized, { _, _ in
            if let isAuthorized, isAuthorized == true {
                action()
            }
        })
    }
}
