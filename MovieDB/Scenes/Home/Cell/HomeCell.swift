import UIKit
import SnapKit

protocol HomeCellConfigurable {
    func setupCell(with viewModel: HomeCellViewModel)
}

final class HomeCell: UITableViewCell {
    static var identifier: String {
        String(describing: HomeCell.self)
    }
    
    private lazy var cellIMageView: Image = {
        let image = Image(roundBorder: 12, frame: .zero)
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: Label = {
        let label = Label()
        return label
    }()
    
    private lazy var subTitlelabel: Label = {
        let label = Label(ofSize: 14, weight: .regular, color: .lightGray)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitlelabel])
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
        cellIMageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 90, height: 120))
        }
        
        titleStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(cellIMageView.snp.centerY)
            make.leading.equalTo(cellIMageView.snp.trailing).offset(16)
        }
    }
}

extension HomeCell: HomeCellConfigurable {
    func setupCell(with viewModel: HomeCellViewModel) {
        titleLabel.text = viewModel.title
        subTitlelabel.text = viewModel.releaseDate
        cellIMageView.loadImage(from: viewModel.imagePath)
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
                imagePath: nil
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
