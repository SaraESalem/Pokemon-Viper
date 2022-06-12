
import Foundation

class SpeciesListInteractor: SpeciesListInteractorInputProtocol {
    
    weak var presenter: SpeciesListInteractorOutputProtocol?
    
    func fetchSpecies(offset: Int,limit:Int){
        
        APIClient.getSpeciesList(limit: limit, offset: offset) { [weak self] (response) in
            
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.presenter?.speciesFetchedSuccessfully(model: result)
            case .failure(let error):
                self.presenter?.speciesFetchingFailed(withError: error)
            }
        }
    }
    
   
}
