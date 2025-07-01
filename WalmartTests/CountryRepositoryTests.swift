import XCWalmart
@testable import Walmart

final class CountryRepositoryWalmarts: XCWalmartCase {
    
    var mockNetworkService: MockNetworkService!
    var repository: CountryRepository!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        repository = CountryRepository(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async throws {
        let countries = try await repository.getCountries()
        XCTAssertEqual(countries.count, 1)
        XCTAssertEqual(countries.first?.name, "Canada")
    }
    
    func testFetchCountriesFailure() async {
        mockNetworkService.shouldReturnError = true
        
        do {
            _ = try await repository.getCountries()
            XCTFail("Expected an error, but no error was thrown.")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}


