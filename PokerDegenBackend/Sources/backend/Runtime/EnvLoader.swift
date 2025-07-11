import Foundation

func loadEnvFile() {
    guard let contents = try? String(contentsOfFile: ".env", encoding: .utf8) else {
        print("Failed to read .env file")
        return
    }

    for line in contents.split(separator: "\n") {
        let parts = line.split(separator: "=", maxSplits: 1).map { $0.trimmingCharacters(in: .whitespaces) }
        if parts.count == 2 {
            setenv(parts[0], parts[1], 1)
        }
    }
}
