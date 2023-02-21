import Kingfisher
import SnapKit
import UIKit

protocol DetailViewProtocol {
    func configure(with model: MovieModel)
}

protocol DetailViewDelegate: AnyObject {
    func closeButtonTapped()
}

private extension MovieDetailView.Layout {
    enum Size {
        static var roundBorder = 12.0
        static var titleLabelSize = 28.0
        static var detailLabelSize = 15.0
        static var stackSpacing = 20.0
        static var imageTop = 30.0
        static var imageHeight = 250.0
        static var imageWidth = 200.0
        static var stackTop = 20.0
        static var stackEdges = 16.0
    }
}

final class MovieDetailView: UIView {
    enum Layout {}
    
    private lazy var imageView: Image = {
        let image = Image(roundBorder: Layout.Size.roundBorder, frame: .zero)
        return image
    }()
    
    private lazy var titleLabel: Label = {
        let label = Label(ofSize: Layout.Size.titleLabelSize)
        return label
    }()
    
    private lazy var detailLabel: Label = {
        let label = Label(ofSize: Layout.Size.detailLabelSize)
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
        stack.spacing = Layout.Size.stackSpacing
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
            make.top.equalTo(Layout.Size.imageTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(Layout.Size.imageHeight)
            make.width.equalTo(Layout.Size.imageWidth)
        }
       
        contentView.snp.makeConstraints { make in
            make.top.edges.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(scrollView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Layout.Size.stackTop)
            make.leading.equalToSuperview().offset(Layout.Size.stackEdges)
            make.trailing.equalToSuperview().offset(-Layout.Size.stackEdges)
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

