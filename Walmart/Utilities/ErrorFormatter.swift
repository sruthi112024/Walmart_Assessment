import Foundation

enum NetworkErrorFormatter {
    static func userMessage(from error: Error) -> String {
        if let apiError = error as? APIError {
            switch apiError {
            case .decoding(let underlying):
                return "Failed to decode data: \(underlying.localizedDescription)"
            case .response(let httpResponse):
                return "Server error: \(httpResponse.description)"
            case .network(let netError):
                return "Network issue: \(netError)"
            }
        }

        return "Something went wrong. Please try again."
    }
}
