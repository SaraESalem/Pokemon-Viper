
import Foundation

protocol SpeciesListViewProtocol: AnyObject { // by vc
    var presenter: SpeciesListPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    func emptySpeciesList()
    func showErrorMessage(message: Error)
}

protocol SpeciesListPresenterProtocol: AnyObject {
    var view: SpeciesListViewProtocol? { get set }
    
    var inSearchMode:Bool { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func doSearch(searchText:String)
    func getSpecies(at index : Int)->Species
    func selectSpecies(at index:Int)
    
    func setOffset()
    func resetOffset()
}

protocol SpeciesListRouterProtocol {
    func navigateToSpecieDetails(_ item: Species)
}

protocol SpeciesListInteractorInputProtocol {
    var presenter: SpeciesListInteractorOutputProtocol? { get set }
    func fetchSpecies(offset: Int,limit: Int)
}

protocol SpeciesListInteractorOutputProtocol: AnyObject { // implemented by presenter
    func speciesFetchedSuccessfully(model: SpeciesResponse)
    func speciesFetchingFailed(withError error: Error)
}
