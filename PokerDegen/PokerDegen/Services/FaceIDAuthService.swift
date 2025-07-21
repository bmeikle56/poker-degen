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
        throw error ?? NSError(domain: "FaceID", code: -1, userInfo: [NSLocalizedDescriptionKey: "Biometric authentication not available"])
    }

    let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
    return success
}
