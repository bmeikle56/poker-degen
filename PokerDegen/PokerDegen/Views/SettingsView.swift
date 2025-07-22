//
//  SettingsView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

struct SettingsView: View {
    let navigationController: UINavigationController
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showDisableFaceIDAlert = false
    
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
            .padding(.vertical, 25)
            Spacer()
            VStack {
                Button(action: {
                    showDisableFaceIDAlert = true
                }, label: {
                    Text("Disable FaceID")
                        .foregroundStyle(Color.pdBlue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.pdBlue, lineWidth: 2)
                        )
                })
            }
            .alert("Disable FaceID?", isPresented: $showDisableFaceIDAlert) {
                Button("Disable", role: .destructive) {
                    UserDefaults.standard.set(false, forKey: "biometrics")
                }
                Button("Cancel", role: .cancel) {
                    /// do nothing by design...
                }
            }
            Spacer().frame(height: 40)
            Button(action: {
                dismiss()
                navigationController.popToRootViewController(animated: true)
            }, label: {
                Text("Log out")
                    .foregroundStyle(Color.pdBlue)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.pdBlue, lineWidth: 2)
                    )
            })
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
