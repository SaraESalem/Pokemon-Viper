
import Foundation

class SpecieDetailsPresenter:SpecieDetailsPresenterProtocol,SpecieDetailsInteractorOutputProtocol{
 
    weak var view: SpecieDetailsViewProtocol?
    private let interactor: SpecieDetailsInteractorInputProtocol
    
    
    var speciesDetailsModel : SpeciesDetails?
    var evolutionChainModel:EvolutionChainDetails?
    var specie : Species?
    
    init(view: SpecieDetailsViewProtocol, interactor: SpecieDetailsInteractorInputProtocol) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
        interactor.fetchSpecieDetails()
    }
    
    func specieDetailsFetchedSuccessfully(model: SpeciesDetails) {
        view?.hideLoadingIndicator()
        self.speciesDetailsModel = model
        interactor.fetchEvolutionChain()
    }
    
    func specieDetailsFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    
    func evolutionChainFetchedSuccessfully(model: EvolutionChainDetails) {
     
        view?.hideLoadingIndicator()
        self.evolutionChainModel = model
        view?.populateSpecieDetails(data:SpeciesDetailsViewModel(model: speciesDetailsModel, specie: specie, evolutionChainModel: evolutionChainModel))
    }
    
    func evolutionChainFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    
}
