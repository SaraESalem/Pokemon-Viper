
import Foundation
 
class SpeciesListPresenter: SpeciesListPresenterProtocol, SpeciesListInteractorOutputProtocol {
    
    weak var view: SpeciesListViewProtocol?
    private let interactor: SpeciesListInteractorInputProtocol
    private let router: SpeciesListRouterProtocol
    
    
    private var species: [Species] = []
    private var filteredSpecies = [Species]()
    
    var offset: Int = 0
    var totalOffsets = 0
    var limit = 10
    
    var inSearchMode:Bool = false

    var numberOfRows: Int {
        return inSearchMode ? filteredSpecies.count : species.count
    }
    
    init(view: SpeciesListViewProtocol, interactor: SpeciesListInteractorInputProtocol, router: SpeciesListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        if offset <= totalOffsets{
            view?.showLoadingIndicator()
            interactor.fetchSpecies(offset: offset, limit: limit)
        }
    }
    
    func getSpecies(at index: Int) -> Species {
        return inSearchMode ? filteredSpecies[index] : species[index]
    }
    
    func selectSpecies(at index: Int) {
        if inSearchMode{
            filteredSpecies[index].index = index+1
            router.navigateToSpecieDetails(filteredSpecies[index])
        }else{
            species[index].index = index+1
            router.navigateToSpecieDetails(species[index])
        }
    }
    
    func setOffset(){
        offset += limit
    }
    func resetOffset(){
        offset = 0
    }
    
    func speciesFetchedSuccessfully(model: SpeciesResponse) {
        view?.hideLoadingIndicator()
        if offset == 0 {
            totalOffsets = model.count
            species.removeAll()
        }
        species += model.results
        setOffset()
        if species.count == 0{
            view?.emptySpeciesList()
        }else{
            view?.reloadData()
        }
        print("offset  ",offset)
    }
    
    func speciesFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showErrorMessage(message: error)
    }
    
    func doSearch(searchText:String){
        filteredSpecies = species.filter({ $0.name.range(of: searchText) != nil })
    }
}
