import XCWalmart
import Combine
@testable import Walmart

@MainActor
final class CountryListViewModelWalmarts: XCWalmartCase {
    
    var mockUseCase: FetchCountries!
    var mockRepository: MockCountryRepository!
    var viewModel: CountryListViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCountryRepository()
        mockUseCase = FetchCountries(repository: mockRepository)
        viewModel = CountryListViewModel(fetchCountries: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        mockRepository = nil
        mockUseCase = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchCountriesSuccess() async {
        await viewModel.fetchCountries()
        
        XCTAssertEqual(viewModel.countries.count, 3)
        XCTAssertEqual(viewModel.filteredCountries.count, 3)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchCountriesFailure() async {
        mockRepository.shouldReturnError = true
        
        await viewModel.fetchCountries()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.countries.count, 0)
    }
    
    func testFilterCountriesByName() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "India")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.name, "India")
    }
    
    func testFilterCountriesByCapital() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "Paris")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.capital, "Paris")
    }
    
    func testFilterCountriesWithNoMatch() async {
        await viewModel.fetchCountries()
        
        viewModel.filterCountries(query: "ABC")
        
        XCTAssertEqual(viewModel.filteredCountries.count, 0)
    }
}
