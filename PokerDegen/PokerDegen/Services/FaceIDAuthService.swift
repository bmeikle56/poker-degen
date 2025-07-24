//
//  FaceIDAuthService.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import LocalAuthentication

func authenticateWithFaceID() async throws -> (Bool, String?) {
    let context = LAContext()
    let reason = "Unlock with Face ID"
    var error: NSError?
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
        return (false, "unable to login with Face ID")
    }
    let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
    if success {
        guard let username = UserDefaults.standard.string(forKey: "username"),
              let password = UserDefaults.standard.string(forKey: "password") else {
            /// unable to find username or password in UserDefaults
            return (false, "unable to login with Face ID")
        }
        return await login(username: username, password: password)
    } else {
        return (false, "unable to login with Face ID")
    }
}
