import Vapor

struct ModelWrapperRequest: Content {
    let viewModel: ViewModel
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

func modelWrapperController(_ req: Request) async throws -> String {
    return try await modelWrapper()
}
