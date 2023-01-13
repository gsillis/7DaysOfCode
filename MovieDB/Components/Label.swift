import UIKit

final class Label: UILabel {
    private let ofSize: CGFloat
    private let weight: UIFont.Weight
    private let color: UIColor
    
    init(
        ofSize: CGFloat = 16 ,
        weight: UIFont.Weight = .bold,
        color: UIColor = .white,
        frame: CGRect = .zero
    ) {
        self.ofSize = ofSize
        self.weight = weight
        self.color = color
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Label {
    func setupLabel() {
        font = .systemFont(ofSize: ofSize, weight: weight)
        textColor = color
        numberOfLines = 0
    }
}
