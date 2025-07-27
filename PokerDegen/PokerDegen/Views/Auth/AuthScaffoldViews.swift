//
//  AuthScaffoldViews.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/13/25.
//

import SwiftUI

struct PokerDegenTitleView: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Diamond()
                    .fill(Color.pdBlue)
                    .frame(width: 20, height: (820/468)*20)
                Spacer().frame(width: 20)
                Text("PokerDegen")
                    .foregroundStyle(Color.pdBlue)
                    .font(.system(size: 34, weight: .bold, design: .default))
            }
            Text("A fast poker solver")
                .foregroundStyle(Color.pdBlue)
                .offset(x: 15)
        }
    }
}

struct AuthErrorMessageView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        if let authorized = authViewModel.authorized,
            authorized == false,
            let message = authViewModel.errorMessage {
            Text(message)
                .foregroundStyle(Color.red)
                .frame(height: 20)
        } else {
            Spacer().frame(height: 20)
        }
    }
}

struct NoAssistantTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NoAssistantTextField

        init(_ parent: NoAssistantTextField) {
            self.parent = parent
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }

    var placeholder: String
    @Binding var text: String
    var secure: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.isSecureTextEntry = secure
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.text = text
        textField.backgroundColor = .clear
        textField.autocapitalizationType = .none
        textField.textColor = UIColor(cgColor: CGColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1))
        textField.borderStyle = .roundedRect

        let item = textField.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []

        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

struct UsernameField: View {
    let placeholder: String
    @ObservedObject var authViewModel: AuthViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        NoAssistantTextField(placeholder: "", text: $authViewModel.username, secure: false)
            .focused($isFocused)
            .placeholder(when: authViewModel.username.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
                    .padding(.horizontal, 8)
            }
            .padding()
            .frame(width: 250)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.pdBlue, lineWidth: 1.4)
            )
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
        NoAssistantTextField(placeholder: "", text: $authViewModel.password, secure: true)
            .focused($isFocused)
            .placeholder(when: authViewModel.password.isEmpty) {
                Text(placeholder)
                    .foregroundColor(.smoothGray)
                    .padding(.horizontal, 8)
            }
            .padding()
            .frame(width: 250)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.pdBlue, lineWidth: 1.4)
            )
            .autocapitalization(.none)
            .foregroundStyle(Color.smoothGray)
            .submitLabel(.done)
            .onSubmit {
                isFocused = false
            }
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

struct DeleteAccountButton: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("Delete Account")
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
    }
}
