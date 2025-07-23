//
//  AuthViewModel.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/22/25.
//

import SwiftUI

@MainActor class AuthViewModel: ObservableObject {
    @Published private(set) var authorized: Bool = false
    @Published var username: String = ""
    @Published var password: String = ""
    
    var biometrics: Bool? {
        get { UserDefaults.standard.value(forKey: "biometrics") as? Bool }
        set { UserDefaults.standard.setValue(newValue, forKey: "biometrics") }
    }
    
    func loginUser() {
        Task {
            authorized = await login(username: username, password: password)
        }
    }
    
    func loginUserWithFaceID() {
        Task {
            authorized = try! await authenticateWithFaceID()
        }
    }
    
    func signupUser() {
        Task {
            authorized = await signup(username: username, password: password)
        }
    }
    
    func logout() {
        authorized = false
    }
}
