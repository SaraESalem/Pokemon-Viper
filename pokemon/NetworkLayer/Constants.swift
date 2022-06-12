
import Foundation

struct Constants {
    
    static let baseURL = "https://pokeapi.co/api/v2/"
    static let SpeciebaseImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
}

enum authentication :String{
    case bearer = "Bearer"
}

enum ContentType :String{
    case json = "application/json"
}

enum HTTPHeaderField: String {
    case Content_Type = "Content-Type"
    case Accept = "Accept"
    case authentication = "Authorization"
    case accept_language = "Accept-Language"
}
