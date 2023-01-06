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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitlelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitlelabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
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
        contentView.addSubview(titleStackView)
        contentView.addSubview(cellIMageView)
    }
    
    func setupView() {
        backgroundColor = .customPurple
        selectionStyle = .none
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            cellIMageView.widthAnchor.constraint(equalToConstant: 100),
            cellIMageView.heightAnchor.constraint(equalToConstant: 160),
            cellIMageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellIMageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: cellIMageView.trailingAnchor, constant: 16),
            titleStackView.centerYAnchor.constraint(equalTo: cellIMageView.centerYAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension HomeCell: HomeCellConfigurable {
    func setupCell(with viewModel: HomeCellViewModel) {
        titleLabel.text = viewModel.title
        subTitlelabel.text = viewModel.releaseDate
        cellIMageView.image = UIImage(named: viewModel.image)
    }
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HomeCellPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = HomeCell()
            let model = HomeCellViewModel(
                title: "Any 1",
                releaseDate: "Any 2",
                image: ""
            )
            view.setupCell(with: model)
            return view
        }
        .previewLayout(
            .fixed(
                width: UIScreen.main.bounds.width,
                height: 200
            )
        )
    }
}

#endif
