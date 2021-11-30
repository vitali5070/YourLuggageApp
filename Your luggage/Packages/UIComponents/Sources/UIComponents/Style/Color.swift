import UIKit

public extension UIColor {
    static let limeGreen = UIColor(r: 122, g: 135, b: 30, alpha: 1)
    static let backgroundColor = UIColor(r: 122, g: 135, b: 30, alpha: 0.6)
    static let placeholderColor = UIColor(r: 246, g: 162, b: 30, alpha: 0.6)
    static let forestGreen = UIColor(r: 16, g: 66, b: 16, alpha: 1)
    static let redOrange = UIColor(r: 229, g: 91, b: 19, alpha: 1)
    static let fireOrange = UIColor(r: 246, g: 162, b: 30, alpha: 1)
    static let tripCellDetailViewBackground = UIColor(r: 122, g: 135, b: 30, alpha: 0.9)
}

fileprivate extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: alpha)
    }
}
