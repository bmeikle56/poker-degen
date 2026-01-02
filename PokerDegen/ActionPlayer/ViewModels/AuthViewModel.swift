//
//  AuthViewModel.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

@MainActor class AuthViewModel: ObservableObject {
    @Published private(set) var authorized: Bool?
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    var biometrics: Bool? {
        get { UserDefaults.standard.value(forKey: "biometrics") as? Bool }
        set { UserDefaults.standard.setValue(newValue, forKey: "biometrics") }
    }
    
    func loginUser() {
        /// call service on non-blocking thread
        Task {
            let (auth, err) = await login(username: username, password: password)
            
            /// now switch to main thread to update UI
            await MainActor.run {
                self.authorized = auth
                self.errorMessage = err
            }
        }
    }
    
    func loginUserWithFaceID() {
        Task {
            let (auth, err) = try! await authenticateWithFaceID()
            await MainActor.run {
                self.authorized = auth
                self.errorMessage = err
            }
        }
    }
    
    func signupUser() {
        Task {
            let (auth, err) = await signup(username: username, password: password)
            await MainActor.run {
                self.authorized = auth
                self.errorMessage = err
            }
        }
    }
    
    func deleteAccount() {
        Task {
            let (auth, err) = await delete(username: username, password: password)
            await MainActor.run {
                self.authorized = nil
            }
        }
    }
    
    func logout() {
        authorized = nil
    }
}
