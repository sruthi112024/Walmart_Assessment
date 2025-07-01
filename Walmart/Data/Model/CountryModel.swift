import Foundation

struct CountryModel: Codable {
    let name, region, code, capital: String
    
    func convertToCountry() -> Country {
        return Country(name: name, region: region, code: code, capital: capital)
    }
}
