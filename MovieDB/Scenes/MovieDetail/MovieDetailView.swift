import Kingfisher
import SnapKit
import UIKit

protocol DetailViewProtocol {
    func configure(with model: MovieModel)
}

protocol DetailViewDelegate: AnyObject {
    func closeButtonTapped()
}

final class MovieDetailView: UIView {
    private lazy var imageView: Image = {
        let image = Image(roundBorder: 12, frame: .zero)
        return image
    }()
    
    private lazy var titleLabel: Label = {
        let label = Label(ofSize: 28)
        return label
    }()
    
    private lazy var detailLabel: Label = {
        let label = Label(ofSize: 15)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, detailLabel])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailView: ViewsProtocol {
    func buildConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
       
        stackView.snp.makeConstraints { make in
            make.top.centerX.width.equalToSuperview()
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalToSuperview().offset(400)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = .customPurple
    }
}

extension MovieDetailView: DetailViewProtocol {
    func configure(with model: MovieModel) {
        titleLabel.text = model.title
        detailLabel.text = model.overview
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DetailPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = MovieDetailView()
            return view
        }
        .previewLayout(
            .fixed(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
    }
}

#endif

