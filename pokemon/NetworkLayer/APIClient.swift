import Alamofire
import UIKit

class APIClient {
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,Error>)->Void) -> DataRequest {
        
        return AF.request(route).responseData(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    do{
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let dataResponsed = try decoder.decode(T.self, from: value)
                        completion(.success(dataResponsed))
                    }
                    catch{
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
    
    static func getSpeciesList(limit: Int, offset: Int,completion:@escaping (Result<SpeciesResponse,Error>)->Void) {
        performRequest(route: APIRouter.SpeciesList(limit: limit, offset: offset), completion: completion)
    }
    static func getSpecieDetails(url: URL,completion:@escaping (Result<SpeciesDetails,Error>)->Void) {
        performRequest(route: APIRouter.SpecieDetails(url), completion: completion)
    }
    static func getEvolutionChain(url: URL,completion:@escaping (Result<EvolutionChainDetails,Error>)->Void) {
        performRequest(route: APIRouter.EvolutionChain(url), completion: completion)
    }
}
