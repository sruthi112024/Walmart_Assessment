import Foundation

class CountryAPIService: NetworkService {
    
    private let session: URLSession
    private let validate: (HTTPURLResponse) -> Bool
    
    init(session: URLSession = .shared,
         validate: @escaping (HTTPURLResponse) -> Bool = { $0.statusCode == 200 }) {
        self.session = session
        self.validate = validate
    }
    
    func fetch<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, validate(httpResponse) else {
            throw APIError.response(httpResponse: response)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
}

enum APIError: Error {
    case network(NetworkError)
    case response(httpResponse: URLResponse)
    case decoding(Error)
}
