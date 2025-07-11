import Vapor

struct ModelWrapperRequest: Content {
    let board: ViewModel
}

struct ViewModel: Codable {
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

func modelWrapperController(_ request: Request) async throws -> String {
    let modelWrapperRequest = try request.content.decode(ModelWrapperRequest.self)
    print("__ modelWrapperRequest: \(modelWrapperRequest)")
    return try await modelWrapper()
}
