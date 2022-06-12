

import Foundation

class SpecieDetailsInteractor:SpecieDetailsInteractorInputProtocol{
    
    weak var presenter: SpecieDetailsInteractorOutputProtocol?
    
    var specie : Species?
    var evolutionChain : URL?
    
   // var mainSpeciesURL : URL?
    
    func fetchSpecieDetails(){
        guard let _url = specie?.url else {return}
        //mainSpeciesURL = _url
        APIClient.getSpecieDetails(url: _url) { [weak self] (response:Result<SpeciesDetails,Error>) in
            
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.evolutionChain = result.evolutionChain?.url
                self.presenter?.specieDetailsFetchedSuccessfully(model: result)
            case .failure(let error):
                print(error)
                self.presenter?.specieDetailsFetchingFailed(withError: error)
            }
        }
    }
    
    func fetchEvolutionChain(){
        guard let _url = evolutionChain else {return}
        APIClient.getEvolutionChain(url: _url) { [weak self] (response) in
            
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.presenter?.evolutionChainFetchedSuccessfully(model: result)
            case .failure(let error):
                print(error)
                self.presenter?.evolutionChainFetchingFailed(withError: error)
            }
        }
    }
    
}
