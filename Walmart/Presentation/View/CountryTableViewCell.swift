import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "CountryTableViewCell"
    
    private let nameLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel.font = .boldSystemFont(ofSize: 17)
        capitalLabel.font = .systemFont(ofSize: 15)
        codeLabel.font = .systemFont(ofSize: 15)
        codeLabel.textAlignment = .right
        
        nameLabel.numberOfLines = 1
        capitalLabel.numberOfLines = 1
        codeLabel.numberOfLines = 1
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, codeLabel])
        nameStackView.axis = .horizontal
        nameStackView.distribution = .equalSpacing
        
        let mainStackView = UIStackView(arrangedSubviews: [nameStackView, capitalLabel])
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
    }
    
    func configure(with country: Country) {
        nameLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}
