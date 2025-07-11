import Foundation
import Vapor

//func modelWrapper(with model: CardViewModel) async throws -> String {
func modelWrapper() async throws -> String {
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!
    let model = "gpt-4.1-mini"
    let apiKey = Environment.get("OPENAI_API_KEY")!
    
    var request = Foundation.URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let prompt = """
    Given the following, provide me the highest EV action and why:
    pot: 6bb
    community cards: 2h, 6h, qh
    hero (BTN): ac, kh
    villain (BB): 4h, 5s
    flop: villain check, hero bet 2bb, villain raise 7bb
    """

    let body: [String: Any] = [
        "model": model,
        "messages": [
            ["role": "user", "content": prompt]
        ]
    ]
    
    request.httpBody = try JSONSerialization.data(withJSONObject: body)

    let (data, _) = try await Foundation.URLSession.shared.data(for: request)
    let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    let choices = json?["choices"] as? [[String: Any]]
    let message = choices?.first?["message"] as? [String: Any]
    let content = message?["content"] as? String
    return content!
}
