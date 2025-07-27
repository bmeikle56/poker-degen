//
//  Services.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/8/25.
//

import Foundation

func login(username: String, password: String) async -> (Bool, String?) {
    let path = "/login"
    let method = "POST"
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    let httpBody = try! JSONSerialization.data(withJSONObject: body)
    let data = await fetchData(path: path, method: method, httpBody: httpBody)
    let response = data?["response"] as? String
    if let response, response == "login successful", let key = data?["token"] as? String {
        /// successful login
        apiKey = key
        return (true, nil)
    } else if let response, response == "failed to login user", let error = data?["error"] as? String {
        /// unsuccessful login
        return (false, error)
    }
    return (false, nil)
}

func signup(username: String, password: String) async -> (Bool, String?) {
    let path = "/signup"
    let method = "POST"
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    let httpBody = try! JSONSerialization.data(withJSONObject: body)
    let data = await fetchData(path: path, method: method, httpBody: httpBody)
    let response = data?["response"] as? String
    if let response, response == "sign up successful", let key = data?["token"] as? String {
        /// successful signup
        apiKey = key
        return (true, nil)
    } else if let response, response == "failed to signup user", let error = data?["error"] as? String {
        /// unsuccessful signup
        return (false, error)
    }
    return (false, nil)
}

func delete(username: String, password: String) async -> (Bool, String?) {
    let path = "/deleteAccount"
    let method = "POST"
    let body: [String: Any] = [
        "username": username,
        "password": password
    ]
    let httpBody = try! JSONSerialization.data(withJSONObject: body)
    let data = await fetchData(path: path, method: method, httpBody: httpBody)
    let response = data?["response"] as? String
    if let response, response == "delete successful" {
        /// successful login
        return (true, nil)
    } else if let response, response == "failed to delete user", let error = data?["error"] as? String {
        /// unsuccessful login
        return (false, error)
    }
    return (false, nil)
}

func analyze(viewModel: HandViewModel) async throws -> [String] {
    let path = "/modelWrapper"
    let method = "POST"
    let body = viewModel.boardData
    let httpBody = try JSONEncoder().encode(body)
    if let data = await fetchData(path: path, method: method, httpBody: httpBody) {
        return data["response"] as! [String]
    }
    return ["Unable to analyze"]
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

private let scheme = "https://"
private let host = "poker-degen-backend-production.up.railway.app"
private var apiKey: String?

private enum ServiceError: Error {
    case statusCode
}

private func fetchData(path: String, method: String, httpBody: Data? = nil) async -> [String: Any]? {
    let url = URL(string: scheme + host + path)!
    var request = URLRequest(url: url)
    request.httpMethod = method
    if let apiKey {
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    do {
        if let httpBody {
            request.httpBody = httpBody
        }
        let (data, _) = try await URLSession.shared.data(for: request) as! (Data, HTTPURLResponse)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        return json
    } catch {
        /// this is bad, force a crash...
        return nil
    }
}
