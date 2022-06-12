import UIKit

class ListCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ListCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .systemGroupedBackground
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appTheme
        view.addSubview(nameLabel)
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = ""
        return label
    }()
    
    func populate(item: Species,index:Int) {
        nameLabel.text = item.name
        imageView.setImageWithUrlString(urlStr: "\(Constants.SpeciebaseImage)\(index+1).png", placholder: UIImage(named: "PlaceholderImage") )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
        setupConstraints()
    }
    private func setupViews() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        contentView.addSubviews(imageView, nameContainerView)
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant:  frame.height - 32),
            
            nameContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameContainerView.heightAnchor.constraint(equalToConstant: 32),
            
            nameLabel.centerXAnchor.constraint(equalTo: nameContainerView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: nameContainerView.centerYAnchor),
        ])
    }
}
