import XCWalmart
@testable import Walmart

class MockCountryRepository: CountryRepositoryProtocol {
    
    var shouldReturnError = false
    var mockCountries: [Country] = [
        Country(name: "Canada", region: "North America", code: "CA", capital: "Ottawa"),
        Country(name: "France", region: "Europe", code: "FR", capital: "Paris"),
        Country(name: "India", region: "Asia", code: "IN", capital: "New Delhi")
    ]
    
    func getCountries() async throws -> [Country] {
        if shouldReturnError {
            let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            throw APIError.response(httpResponse: response)
        }
        return mockCountries
    }
}

final class fetchCountriesWalmarts: XCWalmartCase {
    
    var mockRepository: MockCountryRepository!
    var useCase: FetchCountries!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        useCase = FetchCountries(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async {
        do {
            let countries = try await useCase.execute()
            XCTAssertEqual(countries.count, 3)
            XCTAssertEqual(countries.first?.name, "Canada")
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    func testFetchCountriesFailure() async {
        mockRepository.shouldReturnError = true
        
        do {
            _ = try await useCase.execute()
            XCTFail("Expected an error, but no error was thrown.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

