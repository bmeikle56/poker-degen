//
//  ChatGPTService.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/8/25.
//

import Foundation

let scheme = "https://"
let host = "poker-degen-backend-production.up.railway.app"
let apiKey = "pokerdegen"

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

enum ServiceError: Error {
    case statusCode
}

private func fetchData(path: String, method: String, body: [String: Any]? = nil) async -> ([String: Any], HTTPURLResponse)? {
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
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        return (json, response)
    } catch {
        /// do something with error...
        return nil
    }
}

func callChatGPT(with model: CardViewModel) async throws -> Any {
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    let model = "gpt-4.1-mini"
    //let apiKey = "api-key"
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let body: [String: Any] = [
        "model": model,
        "messages": [
            ["role": "user", "content": "What is the capital of France?"]
        ]
    ]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body)

    let (data, _) = try await URLSession.shared.data(for: request)
    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    let choices = json?["choices"] as? [[String: Any]]
    let message = choices?.first?["message"] as? [String: Any]
    let content = message?["content"] as? String
    print(content)
    return content
}

/**
 Given the following, provide me the highest EV action and why:
 pot: 6bb
 community cards: 2h, 6h, qh
 hero (BTN): ac, kh
 villain (BB): 4h, 5s
 flop: villain check, hero bet 2bb, villain raise 7bb
 */
