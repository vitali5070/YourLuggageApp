import UIKit

public enum ImageType {
    case bundle(String)
    case url(String)
}

public protocol ImageViewModelProtocol {
    var image: ImageType { get }
    var contentMode: UIView.ContentMode { get }
    var backgroundColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var borderColor: UIColor? { get }
}

public class ImageViewModel: ImageViewModelProtocol {
    public let image: ImageType
    public let contentMode: UIView.ContentMode
    public let backgroundColor: UIColor
    public let borderWidth: CGFloat
    public let borderColor: UIColor?

    public init(
        image: ImageType,
        contentMode: UIView.ContentMode = .scaleToFill,
        backgroundColor: UIColor = .clear,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = nil
    ) {
        self.image = image
        self.contentMode = contentMode
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
}
