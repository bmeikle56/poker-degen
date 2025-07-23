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
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        if let authorized = authViewModel.authorized, authorized == false {
            Text(message)
                .foregroundStyle(Color.red)
        } else {
            Spacer().frame(height: 20)
        }
    }
}

struct UsernameField: View {
    let placeholder: String
    @ObservedObject var authViewModel: AuthViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        TextField("", text: $authViewModel.username)
            .focused($isFocused)
            .placeholder(when: authViewModel.username.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
            }
            .padding()
            .frame(width: 250, height: 50) // Ensures tappable area is consistent
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
    @ObservedObject var authViewModel: AuthViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        SecureField("", text: $authViewModel.password)
            .focused($isFocused)
            .placeholder(when: authViewModel.password.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
            }
            .padding()
            .frame(width: 250, height: 50) // Ensures tappable area is consistent
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

struct SignupButton: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button(action: {
            authViewModel.signupUser()
        }, label: {
            Text("Signup")
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .bold, design: .default))
                .padding()
                .frame(width: 250)
                .background(Color.pdBlue)
                .cornerRadius(8)
        })
        .onChange(of: authViewModel.authorized, { _, _ in
            if authViewModel.authorized == true {
                navigationController.pushViewController(
                    UIHostingController(rootView: PokerTableView(
                        navigationController: navigationController,
                        authViewModel: authViewModel
                    )),
                    animated: true
                )
            }
        })
    }
}

struct LoginButton: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var showFaceIDPrompt = false

    var body: some View {
        Button(action: {
            guard let useBiometrics = UserDefaults.standard.value(forKey: "biometrics") as? Bool else {
                /// "biometrics" = nil, first login
                showFaceIDPrompt = true
                return
            }
            if !useBiometrics {
                authViewModel.loginUser()
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
        .onChange(of: authViewModel.authorized, { _, _ in
            if let authorized = authViewModel.authorized, authorized == true {
                navigationController.pushViewController(
                    UIHostingController(rootView: PokerTableView(
                        navigationController: navigationController,
                        authViewModel: authViewModel
                    )),
                    animated: true
                )
            }
        })
        .alert("Enable Face ID?", isPresented: $showFaceIDPrompt) {
            Button("Continue") {
                UserDefaults.standard.set(authViewModel.username, forKey: "username")
                UserDefaults.standard.set(authViewModel.password, forKey: "password")
                authViewModel.loginUserWithFaceID()
                authViewModel.biometrics = true
                UserDefaults.standard.set(true, forKey: "biometrics")
            }
            Button("Cancel", role: .cancel) {
                authViewModel.loginUser()
                authViewModel.biometrics = false
            }
        } message: {
            Text("Use Face ID to log in quickly and securely.")
        }
    }
}
