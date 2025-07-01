import Foundation
import Combine

@MainActor
class CountryListViewModel: ObservableObject {
    
    private let fetchCountries: FetchCountriesProtocol
    @Published var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    init(fetchCountries: FetchCountriesProtocol) {
        self.fetchCountries = fetchCountries
    }
    
    func fetchCountries() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedCountries = try await fetchCountries.execute()
            self.countries = fetchedCountries
            self.filteredCountries = fetchedCountries
        } catch {
            self.errorMessage = NetworkErrorFormatter.userMessage(from: error)
        }
    }
    
    func filterCountries(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedQuery.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter {
                $0.name.lowercased().contains(trimmedQuery.lowercased()) ||
                $0.capital.lowercased().contains(trimmedQuery.lowercased())
            }
        }
    }
}
