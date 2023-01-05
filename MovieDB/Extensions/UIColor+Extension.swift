import UIKit

extension UIColor {
    convenience init(customRed: Int, customGreen: Int, customBlue: Int) {
        self.init(
            red: CGFloat(customRed) / 255.0,
            green: CGFloat(customGreen) / 255.0,
            blue: CGFloat(customBlue) / 255.0,
            alpha: 1
        )
    }
    
    static let customPurple = UIColor(customRed: 46, customGreen: 19, customBlue: 113)
}
