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
        scroll.alwaysBounceVertical = true
        scroll.isUserInteractionEnabled = true
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
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
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(200)
        }
       
        contentView.snp.makeConstraints { make in
            make.top.edges.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
    }
    
    func setupView() {
        backgroundColor = .customPurple
    }
}

extension MovieDetailView: DetailViewProtocol {
    func configure(with model: MovieModel) {
        titleLabel.text = model.title
        detailLabel.text = model.overview
        imageView.loadImage(from: model.posterPathImage)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct DetailPreview: PreviewProvider {
    static var previews: some View {
        Preview {
            let view = MovieDetailView()
            let model = MovieModel(
                posterPath: "any",
                adult: false,
                overview: "any",
                releaseDate: "any",
                genreIDS: [1],
                id: 0,
                originalTitle: "any",
                originalLanguage: "any",
                title: "any",
                backdropPath: "any",
                popularity: 0.0,
                voteCount: 1,
                video: false,
                voteAverage: 0.0
            )
            view.configure(with: model)
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

