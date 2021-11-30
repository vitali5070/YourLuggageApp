import UIKit


public class TextFieldView: UITextField {
    let viewModel: TextFieldViewModelProtocol
    let inset: CGFloat = 10
    
    public init(viewModel: TextFieldViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        text = viewModel.text
        backgroundColor = viewModel.backgroundColor
        textColor = viewModel.textColor
        keyboardType = viewModel.keyboardType
        textContentType = viewModel.textContentType
        autocapitalizationType = viewModel.textAutocapitalizationType
        spellCheckingType = viewModel.textSpellCheckingType
        layer.borderColor = viewModel.borderColor?.cgColor

        if let borderWidth = viewModel.borderWidth {
            layer.borderWidth = borderWidth
        }
        
        if let cornerRadius = viewModel.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        
        attributedPlaceholder = NSAttributedString(string: viewModel.placeholder, attributes: [
            NSAttributedString.Key.foregroundColor : viewModel.placeholderColor]
        )
                
        viewModel.state = { [weak self] state in
            switch state {
            case .success:
                self?.layer.borderColor = UIColor.clear.cgColor
                
            case .failed(error: let error):
                print(error)
                self?.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets().authTextFieldEdgeInsets())
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets().authTextFieldEdgeInsets())
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets().authTextFieldEdgeInsets())
    }
    
    @objc private func editingChanged() {
        viewModel.text = text
    }
    
    @objc private func editingDidEnd() {
        if viewModel.validateOnEndActive {
            viewModel.validate()
        }
    }
}
