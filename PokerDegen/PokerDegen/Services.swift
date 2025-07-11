//
//  ChatGPTService.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/8/25.
//

import Foundation

let scheme = "https://"
let host = "poker-degen-backend-production.up.railway.app"
let apiKey = "pokerdegen" /// this needs to go in the Keychain...

func login(username: String, password: String) async {
    let path = "/login"
    let method = "POST"
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    let (data, _) = await fetchData(path: path, method: method, body: body)!
    print("data: \(data)")
}

func analyze(board: CardViewModel) async throws -> String {
    let path = "/modelWrapper"
    let method = "POST"
    let body: [String: Any] = [
        "board": board,
    ]
    let httpBody = try JSONSerialization.data(withJSONObject: body)
    print("httpBody: \(httpBody)")
    let (data, _) = await fetchData(path: path, method: method, body: body)!
    print("data: \(data)")
    return data
}


///
///
///
///
/// #### Encapsulated service library code ####
///
///
///
///

private enum ServiceError: Error {
    case statusCode
}

private func fetchData(path: String, method: String, body: [String: Any]? = nil) async -> (String, HTTPURLResponse)? {
    let url = URL(string: scheme + host + path)!
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        if let body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }
        let (data, response) = try await URLSession.shared.data(for: request) as! (Data, HTTPURLResponse)
        if (response.statusCode != 200) {
            throw ServiceError.statusCode
        }
        
        let decodedString = String(data: data, encoding: .utf8)!
        return (decodedString, response)
    } catch {
        /// do something with error...
        return nil
    }
}
