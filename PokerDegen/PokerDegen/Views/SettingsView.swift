//
//  SettingsView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI
import SafariServices

struct ExitButton: View {
    let action: DismissAction
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }, label: {
                Image(systemName: "multiply")
                    .font(.title2)
                    .foregroundStyle(Color.pdBlue)
            })
            Spacer()
        }
        .padding(.horizontal, 50)
        .padding(.vertical, 10)
    }
}

struct SettingsButton: View {
    let action: () -> Void
    let text: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .foregroundStyle(Color.pdBlue)
                .frame(width: 180, height: 60)
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
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showDisableFaceIDAlert = false
    @State private var showWebView = false
    
    private var biometrics: Bool {
        UserDefaults.standard.value(forKey: "biometrics") as? Bool ?? false
    }
    
    var body: some View {
        VStack {
            ExitButton(action: dismiss)
            Spacer()
            SettingsButton(
                action: {
                    showDisableFaceIDAlert = true
                },
                text: "\(biometrics ? "Disable" : "Enable") FaceID"
            )
            .alert("\(biometrics ? "Disable" : "Enable") FaceID?", isPresented: $showDisableFaceIDAlert) {
                Button("\(biometrics ? "Disable" : "Enable")", role: .destructive) {
                    UserDefaults.standard.set(!biometrics, forKey: "biometrics")
                }
                Button("Cancel", role: .cancel) {
                    /// do nothing by design...
                }
            }
            Spacer().frame(height: 20)
            Button(action: {
                authViewModel.logout()
                dismiss()
                navigationController.popToRootViewController(animated: true)
            }, label: {
                Text("Log out")
                    .foregroundStyle(Color.pdBlue)
                    .frame(width: 180, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pdBlue, lineWidth: 2)
                    )
            })
            Spacer().frame(height: 20)
            Button(action: {
                authViewModel.deleteAccount()
                dismiss()
                navigationController.popToRootViewController(animated: true)
            }, label: {
                Text("Delete account")
                    .foregroundStyle(Color.pdBlue)
                    .frame(width: 180, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pdBlue, lineWidth: 2)
                    )
            })
            Spacer()
            HStack {
                WebLinkText(
                    text: "Support",
                    url: "https://pokerdegen.app/support",
                    navigationController: navigationController
                )
                
                WebLinkText(
                    text: "Privacy",
                    url: "https://pokerdegen.app/privacy",
                    navigationController: navigationController
                )
            }
            .padding(.vertical, 40)
            
        }
        .frame(maxWidth: .infinity)
        .background(.black)
    }
}
