import UIKit

protocol HomeCellConfigurable {
    func setupCell(with viewModel: HomeCellViewModel)
}

final class HomeCell: UITableViewCell {
    static var identifier: String {
        String(describing: HomeCell.self)
    }
    
    private lazy var cellIMageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cellIMageView, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeCell: ViewsProtocol {
    func buildViewHierarchy() {
        contentView.addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = .customPurple
        selectionStyle = .none
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}

extension HomeCell: HomeCellConfigurable {
    func setupCell(with viewModel: HomeCellViewModel) {
        titleLabel.text = viewModel.title
        cellIMageView.image = UIImage(named: viewModel.image)
    }
}
