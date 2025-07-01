import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder) async throws -> T
}
