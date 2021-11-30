import UIKit

public struct Typography {
    let color: UIColor
    let font: UIFont?
    
    init(color: UIColor, font: UIFont?) {
        self.color = color
        self.font = font
    }
}

public extension Typography {
    // Title
    static let orangeSFProDisplayRegularSmall = Typography(color: .fireOrange, font: UIFont.default(18))
    static let blackSFProDisplayRegularSmall = Typography(color: .black, font: UIFont.default(18))
    static let forestGreenSFProDisplayRegularSmall = Typography(color: .forestGreen, font: UIFont.default(18))
    static let blackSFProDisplayBoldLarge = Typography(color: .black, font: UIFont.bold(28))
    static let forestGreenSFProDisplayBoldLarge = Typography(color: .forestGreen, font: UIFont.bold(28))
    static let tripsMainTitle = Typography(color: .black, font: UIFont.semiBold(24))
    static let navigationTitle = Typography(color: .forestGreen, font: UIFont.semiBold(18))
    static let tripCellCityLabel = Typography(color: .fireOrange, font: UIFont.bold(18))
    static let tripCellDateLabel = Typography(color: .fireOrange, font: UIFont.semiBold(14))
    static let rectButton = Typography(color: .forestGreen, font: UIFont.bold(24))
    static let addTripTitle = Typography(color: .forestGreen, font: UIFont.semiBold(20))
    
    // Subtitle
    static let navigationSubtitle = Typography(color: .black, font: UIFont.semiBold(18))
}

public extension UILabel {
    func apply(typography: Typography) {
        font = typography.font
        textColor = typography.color
    }
}

public extension UITextField {
    func apply(typography: Typography) {
        font = typography.font
        textColor = typography.color
    }
}

public extension UIButton {
    func apply(typography: Typography) {
        titleLabel?.font = typography.font
        [UIControl.State.normal, .highlighted, .disabled, .selected].forEach { state in
            setTitleColor(typography.color, for: state)
        }
    }
}

public extension UIFont {
    static func `default`(_ size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Regular", size: size)
    }
    
    static func `bold`(_ size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Bold", size: size)
    }
    
    static func `semiBold`(_ size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Semibold", size: size)
    }
    
    static func `thin`(_ size: CGFloat) -> UIFont? {
        UIFont(name: "SFProDisplay-Thin", size: size)
    }
}
