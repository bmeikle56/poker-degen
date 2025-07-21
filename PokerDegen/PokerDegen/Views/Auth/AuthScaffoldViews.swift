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
            Diamond()
                .fill(Color.pdBlue)
                .frame(width: 20, height: (820/468)*20)
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
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: $username)
            .focused($isFocused)
            .placeholder(when: username.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
            }
            .padding()
            .frame(width: 250, height: 60) // Ensures tappable area is consistent
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.pdBlue, lineWidth: 1.4)
            )
            .contentShape(RoundedRectangle(cornerRadius: 8)) // Makes the whole area tappable
            .onTapGesture {
                isFocused = true
            }
            .autocapitalization(.none)
            .foregroundStyle(Color.smoothGray)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow {
                placeholder()
            }
            self
        }
    }
}

struct PasswordField: View {
    let placeholder: String
    @Binding var password: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        SecureField("", text: $password)
            .focused($isFocused)
            .placeholder(when: password.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
            }
            .padding()
            .frame(width: 250, height: 60) // Ensures tappable area is consistent
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.pdBlue, lineWidth: 1.4)
            )
            .contentShape(RoundedRectangle(cornerRadius: 8)) // Makes the whole area tappable
            .onTapGesture {
                isFocused = true
            }
            .autocapitalization(.none)
            .foregroundStyle(Color.smoothGray)
    }
}

struct AuthButton: View {
    let navigationController: UINavigationController
    let text: String
    let auth: (String, String) async -> Bool
    
    @Binding var username: String
    @Binding var password: String
    @Binding var isAuthorized: Bool?

    var body: some View {
        Button(action: {
            Task {
                isAuthorized = await auth(username, password)
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
                navigationController.pushViewController(
                    UIHostingController(rootView: MainView(navigationController: navigationController)),
                    animated: true
                )
            }
        })
    }
}
