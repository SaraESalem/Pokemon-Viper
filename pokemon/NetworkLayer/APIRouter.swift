import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    case SpeciesList(limit: Int, offset: Int)
    case SpecieDetails(URL)
    case EvolutionChain(URL)
    
    
    //MARK: - HTTPMETHOD
    private var method : HTTPMethod{
        switch self {
            
        case .SpeciesList,.SpecieDetails,.EvolutionChain:
            return .get
            
        }
    }
    //MARK: - PATH
    private var path:String{
        switch self {
            // By default, a list "page" will contain up to 20 resources. If you would like to change this just add a 'limit' query parameter to the GET request, e.g. ?limit=60. You can use 'offset' to move to the next page, e.g. ?limit=60&offset=60.
        case .SpeciesList(let limit, let offset):
            return "pokemon-species?limit=\(limit)&offset=\(offset)"
        case .SpecieDetails,.EvolutionChain:
            return ""
       
        }
    }
    //MARK: - ENCODING
    internal var encoding : ParameterEncoding{
        switch method {
        case .post,.put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    private var parameters:[String:Any]?{
        return nil
    }
    
    private var url: URL? {
            switch self {
            case .SpecieDetails(let url),
                 .EvolutionChain(let url):
                return url
            case .SpeciesList:
                return URL(string: Constants.baseURL + path)
            }
        }
    
    func asURLRequest() throws -> URLRequest {
        
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        var urlRequest = URLRequest(url: url)
        //HTTP METHOD
        urlRequest.httpMethod = method.rawValue
        
        //HEADER
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.Accept.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.Content_Type.rawValue)
        
        //PARAMETERS
        if let parameters = parameters{
            do{
                print("Parameters \(parameters)")
                
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch{
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
