import Foundation

protocol FetchCountriesProtocol {
    func execute() async throws -> [Country]
}

class FetchCountries: FetchCountriesProtocol {
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Country] {
        return try await repository.getCountries()
    }
}
