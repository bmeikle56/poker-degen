import Vapor

struct ChatMessage: Content {
    let role: String
    let content: String
}

struct ChatRequest: Content {
    let model: String
    let messages: [ChatMessage]
}

struct ChatChoice: Content {
    let message: ChatMessage
}

struct ChatResponse: Content {
    let choices: [ChatChoice]
}

struct ModelWrapperRequest: Content {
    let board: ViewModel
}

struct ViewModel: Content {
    let cc1: String
    let cc2: String
    let cc3: String
    let cc4: String
    let cc5: String
    
    let hc1: String
    let hc2: String
    
    let v1c1: String
    let v1c2: String
}

func modelWrapper(_ request: Request) async throws -> String {
    let modelWrapperRequest = try request.content.decode(ModelWrapperRequest.self)
    let board = modelWrapperRequest.board
    let apiKey = Environment.get("OPENAI_API_KEY")!
    
    let prompt = """
    Given the following, provide me the highest EV action and why:
    pot: 6bb
    community cards: \(board.cc1), \(board.cc2), \(board.cc3)
    hero (BTN): \(board.hc1), \(board.hc2)
    villain (BB): \(board.v1c1), \(board.v1c2)
    flop: villain check, hero bet 2bb, villain raise 7bb
    """

    let chatRequest = ChatRequest(
        model: "gpt-4.1-mini",
        messages: [
            ChatMessage(role: "user", content: prompt)
        ]
    )
    
    let openAIURL = URI(string: "https://api.openai.com/v1/chat/completions")

    let response = try await request.client.post(openAIURL) { clientReq in
        try clientReq.content.encode(chatRequest, as: .json)
        clientReq.headers.bearerAuthorization = .init(token: apiKey)
        clientReq.headers.contentType = .json
    }
    
    guard response.status == .ok else {
        throw Abort(.badRequest, reason: "OpenAI API returned status \(response.status)")
    }
    
    let chatResponse = try response.content.decode(ChatResponse.self)
    guard let content = chatResponse.choices.first?.message.content else {
        throw Abort(.internalServerError, reason: "No content in OpenAI response")
    }
    
    return content
}
