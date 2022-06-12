
import UIKit

class SpeciesListRouter: SpeciesListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = SpeciesListViewController()
        let interactor = SpeciesListInteractor()
        let router = SpeciesListRouter()
        let presenter = SpeciesListPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
    
    static func createSpecieDetailsModule(for item: Species) -> UIViewController {
        let view = SpecieDetailsViewController()
        let interactor = SpecieDetailsInteractor()
        
        let presenter = SpecieDetailsPresenter(view: view, interactor: interactor)
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.specie = item
        presenter.specie = item
        
        return view
    }
    
    func navigateToSpecieDetails(_ item: Species) {
        let vc = SpeciesListRouter.createSpecieDetailsModule(for: item)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
