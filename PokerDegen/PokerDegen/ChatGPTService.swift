//
//  ChatGPTService.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/8/25.
//

import Foundation

func callChatGPT() async throws -> Any {
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    let model = "gpt-4.1-mini"
    let apiKey = "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"
    
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
