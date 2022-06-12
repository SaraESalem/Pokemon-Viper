import UIKit

class SpecieDetailsViewController: UIViewController,SpecieDetailsViewProtocol {
    
    var presenter: SpecieDetailsPresenterProtocol!
    
    let ActivityIndicator = CActivityIndicator()
    
    let topView : UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()
    
    let bottomView : UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .clear
        return vw
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "PlaceholderImage")
        
        return imageView
    }()
    
    let spieceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var evolutionHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appTheme
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(evoLabel)
        evoLabel.translatesAutoresizingMaskIntoConstraints = false
        evoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        evoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    let evoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Next Evolution: "
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let firstEvoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        presenter.viewDidLoad()
        setupViews()
        setupConstraints()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupConstraints(){
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        let safeSrea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: safeSrea.topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeSrea.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeSrea.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            imageView.topAnchor.constraint(equalTo: topView.topAnchor,constant: 16),
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),

            imageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            spieceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 8),
            spieceLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: safeSrea.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: safeSrea.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: safeSrea.trailingAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            evolutionHeaderView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            evolutionHeaderView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            evolutionHeaderView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            evolutionHeaderView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.15),
            
        ])
        
        firstEvoImageView.topAnchor.constraint(equalTo: evolutionHeaderView.bottomAnchor,constant: 16).isActive = true
        firstEvoImageView.leftAnchor.constraint(equalTo: evolutionHeaderView.leftAnchor,constant: 16).isActive = true
        firstEvoImageView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        firstEvoImageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
    }
    private func setupViews() {
        view.addSubviews(topView,bottomView)
        topView.addSubviews(imageView,spieceLabel)
        bottomView.addSubviews(evolutionHeaderView,firstEvoImageView)
    }
}

extension SpecieDetailsViewController{
    
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
    
    func showErrorMessage(message: Error) {
        self.showAlert(error: message)
    }
    func populateSpecieDetails(data:SpeciesDetailsViewModel){

        self.imageView.setImageWithUrlString(urlStr: "\(data.imageURLString)", placholder: UIImage(named: "PlaceholderImage") )
        spieceLabel.text = data.name 
       
        if data.evolutionChainName == "No Evolution"{
            evolutionHeaderView.backgroundColor = .red
            evoLabel.text = "\(data.evolutionChainName)"
            firstEvoImageView.isHidden = true
        }else{
            evoLabel.text = "Next Evolution: \(data.evolutionChainName)"
            UIView.transition(with: evolutionHeaderView, duration: 0.7, options: [.transitionFlipFromTop], animations: nil)
            
            firstEvoImageView.setImageWithUrlString(urlStr: "\(data.evolutionChainImage ?? "")", placholder: UIImage(named: "PlaceholderImage") )
        }
       
    }
}

