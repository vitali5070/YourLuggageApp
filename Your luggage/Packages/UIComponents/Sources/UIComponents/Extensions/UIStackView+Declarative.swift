import UIKit

public extension UIStackView {
    func axis(_ a: NSLayoutConstraint.Axis) -> UIStackView {
        axis = a
        return self
    }
    
    func alignment(_ a: UIStackView.Alignment) -> UIStackView {
        alignment = a
        return self
    }
    
    func distribution(_ d: UIStackView.Distribution) -> UIStackView {
        distribution = d
        return self
    }
    
    func spacing(_ s: CGFloat) -> UIStackView {
        spacing = s
        return self
    }
    
    func with(_ subviews: UIView...) -> UIStackView {
        subviews.forEach { addArrangedSubview($0) }
        return self
    }
    
    func verticalStack() -> UIStackView {
        axis = .vertical
        distribution = .fillEqually
        spacing = 20
        return self
    }
    
    func horizontalStack() -> UIStackView {
        axis = .horizontal
        distribution = .equalSpacing
        spacing = 5
        return self
    }
}
