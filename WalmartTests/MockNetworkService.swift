import Foundation
@testable import Walmart

class MockNetworkService: NetworkService {
    
    var shouldReturnError = false
    var mockData: [CountryDTO] = [
        CountryDTO(name: "India", region: "Asia", code: "IN", capital: "New Delhi")
    ]
    
    func fetch<T>(_ request: URLRequest, decoder: JSONDecoder) async throws -> T where T : Decodable{
        if shouldReturnError {
            throw APIError.response(httpResponse: URLResponseMock())
        }
        
        guard let data = try? JSONEncoder().encode(mockData),
              let decodedData = try? decoder.decode(T.self, from: data) else {
            throw APIError.decoding(NSError(domain: "MockDecoding", code: 1, userInfo: nil))
        }
        
        return decodedData
    }
}

private class URLResponseMock: URLResponse, @unchecked Sendable { }
