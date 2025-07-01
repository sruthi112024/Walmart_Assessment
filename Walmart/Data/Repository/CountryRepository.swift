import Foundation

protocol CountryRepositoryProtocol {
    func getCountries() async throws -> [Country]
}

class CountryRepository: CountryRepositoryProtocol {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getCountries() async throws -> [Country] {
        guard let url = URL(string: Constants.url) else {
            throw NetworkError.invalidURL
        }
        let request = URLRequest(url: url)
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let countryModel: [CountryModel] = try await networkService.fetch(request, decoder: decoder)
            return countryModel.map { $0.convertToCountry() }
        } catch {
            throw error
        }
    }
}
