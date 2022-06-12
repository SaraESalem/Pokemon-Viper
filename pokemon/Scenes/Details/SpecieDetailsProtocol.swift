
import Foundation


protocol SpecieDetailsViewProtocol:AnyObject{
    var presenter: SpecieDetailsPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func populateSpecieDetails(data:SpeciesDetailsViewModel)
    func showErrorMessage(message: Error)
}
protocol SpecieDetailsInteractorInputProtocol {
    var presenter: SpecieDetailsInteractorOutputProtocol? { get set }
    func fetchSpecieDetails()
    func fetchEvolutionChain()
}
protocol SpecieDetailsPresenterProtocol: AnyObject {
    var view: SpecieDetailsViewProtocol? { get set }
    func viewDidLoad()
    
}
protocol SpecieDetailsInteractorOutputProtocol: AnyObject { // implemented by presenter
    func specieDetailsFetchedSuccessfully(model: SpeciesDetails)
    func specieDetailsFetchingFailed(withError error: Error)
    func evolutionChainFetchedSuccessfully(model: EvolutionChainDetails)
    func evolutionChainFetchingFailed(withError error: Error)
}
