import Foundation

/// Response from the `getSpeciesList` endpoint
struct SpeciesResponse: Codable {
    let count: Int
    let results: [Species]
}

/// Species object returned as part of the `SpeciesResponse` object from the `getSpeciesList` endpoint
struct Species : Codable , Equatable{
    
    let name: String
    let url: URL
    var index:Int?
    
    static func ==(lhs: Species, rhs: Species) -> Bool {
        return lhs.url == rhs.url && lhs.name == rhs.name
    }
    
}
