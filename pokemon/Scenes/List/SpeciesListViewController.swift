import UIKit

class SpeciesListViewController: UIViewController,SpeciesListViewProtocol{
    
    var presenter: SpeciesListPresenterProtocol!
    
    let ActivityIndicator = CActivityIndicator()
    let refreshControl = UIRefreshControl()
   
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .white
        return searchBar
    }()
    
    private let wallPaperImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode =  .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "bg")
        return imageView
    }()
    private let collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
       
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ListCell.self, forCellWithReuseIdentifier: ListCell.reuseIdentifier)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    let emptyStateMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No available Species. Pull to refresh"
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
        label.isHidden = true
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
    }
    private func setupConstraints(){
        let safeSrea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            wallPaperImage.topAnchor.constraint(equalTo: view.topAnchor),
            wallPaperImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            wallPaperImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wallPaperImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: safeSrea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeSrea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeSrea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeSrea.trailingAnchor),
            
            emptyStateMessage.centerXAnchor.constraint(equalTo: safeSrea.centerXAnchor),
            emptyStateMessage.centerYAnchor.constraint(equalTo: safeSrea.centerYAnchor,constant: -20)
        ])
        
    }
    private func setupViews() {
        title = "POKéMON"
        configureNavigationBar()
        
        view.addSubviews(wallPaperImage, collectionView, emptyStateMessage)
        searchBar.delegate = self
        configureSearchBarButton()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupRefreshControl()
    }

    func setupRefreshControl() {
        refreshControl.tintColor = UIColor(red: 0.290, green: 0.149, blue: 0.592, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(refreshSpecies), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Species")
        collectionView.addSubview(refreshControl)
    }
    
    @objc func refreshSpecies() {
        presenter.resetOffset()
        presenter.viewDidLoad()
        refreshControl.endRefreshing()
    }
    
}

extension SpeciesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        loadNextPokemon(indexPath: indexPath)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.reuseIdentifier, for: indexPath) as! ListCell
        
        cell.populate(item: presenter.getSpecies(at: indexPath.row), index: indexPath.row)
        return cell
    }
    
    func loadNextPokemon(indexPath: IndexPath){
        // pagination
        let itemsCount = presenter.numberOfRows
        if itemsCount > 0 {
            if  (indexPath.row == itemsCount-1){
                presenter.viewDidLoad()
            }
        }
    }

}

extension SpeciesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectSpecies(at:indexPath.row)
    }
}

extension SpeciesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
}
extension SpeciesListViewController:UISearchBarDelegate{
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .appTheme
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
    }
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    @objc func showSearchBar() {
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .white
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        configureSearchBarButton()
        
        presenter.inSearchMode = false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            presenter.inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            presenter.inSearchMode = true
            presenter.doSearch(searchText: searchText.lowercased())
            collectionView.reloadData()
        }
    }
}

extension SpeciesListViewController {
    
    func showLoadingIndicator() {
        ActivityIndicator.start()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.ActivityIndicator.stop()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showErrorMessage(message: Error) {
        self.showAlert(error: message)
    }
    func emptySpeciesList(){
        emptyStateMessage.isHidden = false
    }
}

