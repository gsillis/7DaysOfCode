import UIKit
import Kingfisher

final class Image: UIImageView {
    private let roundBorder: CGFloat
    
    init(roundBorder: CGFloat,frame: CGRect) {
        self.roundBorder = roundBorder
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from url: URL?) {
        kf.setImage(with: url)
    }
}

private extension Image {
    func setupImageView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius =  roundBorder
        clipsToBounds = true
    }
}
