//
//  SettingsView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI
import SafariServices

struct SettingsViewLayout {
    let spacing: CGFloat
    let fontSize: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let bottomPadding: CGFloat
}

struct ExitButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    action()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.title2)
                        .foregroundStyle(Color.pdBlue)
                })
                .padding(.horizontal, 35)
                .padding(.vertical, 20)
                Spacer()
            }
            Spacer()
        }
    }
}

struct SettingsButton: View {
    let action: () -> Void
    let text: String
    let fontSize: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.system(size: fontSize))
                .foregroundStyle(Color.pdBlue)
                .frame(width: buttonWidth, height: buttonHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.pdBlue, lineWidth: 2)
                )
        })
    }
}

struct SettingsView: View {
    let navigationController: UINavigationController
    @ObservedObject var authViewModel: AuthViewModel
    
    let dismiss: () -> Void
    
    let layout: SettingsViewLayout
    
    @State private var showDisableFaceIDAlert = false
    @State private var showLogoutAccountAlert = false
    @State private var showDeleteAccountAlert = false
    @State private var showWebView = false
    
    private var biometrics: Bool {
        UserDefaults.standard.value(forKey: "biometrics") as? Bool ?? false
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ExitButton(action: { dismiss() })
            VStack(spacing: layout.spacing) {
                Spacer()
                SettingsButton(
                    action: {
                        showDisableFaceIDAlert = true
                    },
                    text: "\(biometrics ? "Disable" : "Enable") FaceID",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight
                )
                .alert("\(biometrics ? "Disable" : "Enable") FaceID?", isPresented: $showDisableFaceIDAlert) {
                    Button("\(biometrics ? "Disable" : "Enable")", role: .destructive) {
                        UserDefaults.standard.set(!biometrics, forKey: "biometrics")
                    }
                    Button("Cancel", role: .cancel) {
                        /// do nothing by design...
                    }
                }
                SettingsButton(
                    action: {
                        showLogoutAccountAlert = true
                    },
                    text: "Log out",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight
                )
                .alert("Are you sure you want to log out?", isPresented: $showLogoutAccountAlert) {
                    Button("Log out", role: .destructive) {
                        authViewModel.logout()
                        dismiss()
                        navigationController.popToRootViewController(animated: true)
                    }
                    Button("Cancel", role: .cancel) {
                        /// do nothing by design...
                    }
                }
                SettingsButton(
                    action: {
                        showDeleteAccountAlert = true
                    },
                    text: "Delete account",
                    fontSize: layout.fontSize,
                    buttonWidth: layout.buttonWidth,
                    buttonHeight: layout.buttonHeight
                )
                .alert("Are you sure you want to delete your account?", isPresented: $showDeleteAccountAlert) {
                    Button("Delete", role: .destructive) {
                        authViewModel.deleteAccount()
                        dismiss()
                        navigationController.popToRootViewController(animated: true)
                    }
                    Button("Cancel", role: .cancel) {
                        /// do nothing by design...
                    }
                }
                Spacer()
                HStack {
                    WebLinkText(
                        text: "Support",
                        url: "https://pokerdegen.app/support",
                        fontSize: layout.fontSize,
                        navigationController: navigationController
                    )
                    
                    WebLinkText(
                        text: "Privacy",
                        url: "https://pokerdegen.app/privacy",
                        fontSize: layout.fontSize,
                        navigationController: navigationController
                    )
                }
                .padding(.vertical, layout.bottomPadding)
            }
        }
    }
}

/// iPhone
#Preview("iPhone") {
    SettingsView(
        navigationController: UINavigationController(),
        authViewModel: AuthViewModel(),
        dismiss: {},
        layout: SettingsViewLayout(
            spacing: 30,
            fontSize: 16,
            buttonWidth: 150,
            buttonHeight: 60,
            bottomPadding: 40,
        )
    )
}

/// iPad
#Preview("iPad") {
    SettingsView(
        navigationController: UINavigationController(),
        authViewModel: AuthViewModel(),
        dismiss: {},
        layout: SettingsViewLayout(
            spacing: 50,
            fontSize: 28,
            buttonWidth: 250,
            buttonHeight: 100,
            bottomPadding: 50,
        )
    )
}
