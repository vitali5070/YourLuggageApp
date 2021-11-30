import UIKit

public class ImageView: UIImageView {
    let viewModel: ImageViewModelProtocol

   public init(viewModel: ImageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        contentMode = viewModel.contentMode
        layer.borderWidth = viewModel.borderWidth
        layer.borderColor = viewModel.borderColor?.cgColor

        switch viewModel.image {
        case .bundle(let name):
            image = UIImage(named: name)

        case .url(let url):
            print(url)
            // async load image
            break
        }
    }

    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}
