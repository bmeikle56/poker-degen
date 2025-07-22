//
//  FaceIDAuthService.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import LocalAuthentication

func authenticateWithFaceID() async throws -> Bool {
    let context = LAContext()
    let reason = "Unlock with Face ID"
    var error: NSError?
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
        return false
    }
    let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
    if success {
        print("userdefaults username: \(UserDefaults.standard.string(forKey: "username"))")
        print("userdefaults password: \(UserDefaults.standard.string(forKey: "password"))")
        guard let username = UserDefaults.standard.string(forKey: "username"),
              let password = UserDefaults.standard.string(forKey: "password") else {
            /// unable to find username or password in UserDefaults
            return false
        }
        print("username: \(username)")
        print("password: \(password)")
        return await login(username: username, password: password)
    } else {
        return false
    }
}
