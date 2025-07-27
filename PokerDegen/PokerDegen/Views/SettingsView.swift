//
//  SettingsView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI
import SafariServices

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
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "multiply")
                        .font(.title2)
                        .foregroundStyle(Color.pdBlue)
                })
                Spacer()
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            Spacer()
            VStack {
                Button(action: {
                    showDisableFaceIDAlert = true
                }, label: {
                    Text("\(biometrics ? "Disable" : "Enable") FaceID")
                        .foregroundStyle(Color.pdBlue)
                        .frame(width: 180, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.pdBlue, lineWidth: 2)
                        )
                })
            }
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
