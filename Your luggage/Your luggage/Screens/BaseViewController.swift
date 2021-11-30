import UIKit

class BaseViewController<ViewModelType>: UIViewController {
    let viewModel: ViewModelType
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        let transparentLayer = CALayer()
        transparentLayer.backgroundColor = UIColor.backgroundColor.cgColor
        transparentLayer.frame = view.bounds
        view.layer.insertSublayer(transparentLayer, at: 0)
    }

    init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Using Storyboards is unavailable for this Task")
    required convenience init?(coder: NSCoder) {
        print("Suppressed an illegal attempt to decode an instance of `\(String(reflecting: Self.self))` using a `\(String(reflecting: NSCoder.self))`.")
        return nil
    }
}
