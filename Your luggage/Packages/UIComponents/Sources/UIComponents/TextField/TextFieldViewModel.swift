import UIKit

public enum TextFieldState: Equatable {
    case success
    case failed(error: String)
    
    public var isValid: Bool {
        return self == .success
    }
}

public protocol TextFieldViewModelProtocol: AnyObject {
    var text: String? { get set }
    var placeholder: String { get }
    var placeholderColor: UIColor { get }
    var textColor: UIColor { get }
    var backgroundColor: UIColor? { get }
    var borderWidth: CGFloat? { get }
    var borderColor: UIColor? { get }
    var cornerRadius: CGFloat? { get }
    var isActive: (Bool) -> Void { get }
    var state: (TextFieldState) -> Void { get set }
    
    var validateOnEndActive: Bool { get }
    var keyboardType: UIKeyboardType { get }
    var textContentType: UITextContentType? { get }
    var textAutocapitalizationType: UITextAutocapitalizationType { get }
    var textSpellCheckingType: UITextSpellCheckingType { get }
    
    @discardableResult
    func validate() -> Bool
}

public class TextFieldViewModel: TextFieldViewModelProtocol {
    public var backgroundColor: UIColor?
    public var borderWidth: CGFloat?
    public var borderColor: UIColor?
    public var placeholderColor: UIColor
    public var textColor: UIColor
    public var cornerRadius: CGFloat?
    public var text: String?
    public let placeholder: String
    public var isActive: (Bool) -> Void = { _ in }
    public var state: (TextFieldState) -> Void = { _ in }
    
    public let validateOnEndActive: Bool
    let validationType: ValidationType
    public var keyboardType: UIKeyboardType { return validationType.keyboardType }
    public var textContentType: UITextContentType? { return validationType.textContentType }
    public var textAutocapitalizationType: UITextAutocapitalizationType { return validationType.textAutocapitalizationType }
    public var textSpellCheckingType: UITextSpellCheckingType { return validationType.textSpellCheckingType }
    
    public init(
        initial: String? = nil,
        placeholder: String,
        backgroundColor: UIColor?,
        borderWidth: CGFloat?,
        borderColor: UIColor?,
        placeholderColor: UIColor,
        textColor: UIColor,
        cornerRadius: CGFloat?,
        validateOnEndActive: Bool,
        type: ValidationType) {
        text = initial
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
        self.validateOnEndActive = validateOnEndActive
        validationType = type
    }
    
    @discardableResult
    public func validate() -> Bool {
        let result = validate(text: text, validators: validationType.validators)
        
        switch result {
        case .success: //$state.onNext(.success)
            state(.success)
            return true
            
        case .failed(let error):
            state(.failed(error: error.localizedString))
            return false
        }
    }
    
    private func validate(text: String?, validators: [TextValidator]) -> ValidationResult {
        var result: ValidationResult
        
        let errors = validators.compactMap { validator -> ValidationError? in
            switch validator.validate(text: text) {
            case .failed(let error): return error
            case .success: return nil
            }
        }
        
        if let first = errors.first {
            if errors.count > 1 {
                result = .failed(error: .multi(errors))
            } else {
                let error: ValidationError
                switch first {
                case .incorrectLength:
                    switch validationType {
                    case .email: error = .invalidEmail
                    case .name: error = .invalidNameLength
                    case .phone: error = .invalidPhone
                    case .password: error = .invalidPasswordLength
                    }
                    
                case .forbiddenСharacter:
                    switch validationType {
                    case .email: error = .invalidEmail
                    case .name: error = .invalidNameSymbols
                    case .phone: error = .invalidPhone
                    case .password: error = .invalidPasswordSymbols
                    }
                    
                default: error = first
                }
                
                result = .failed(error: error)
            }
        } else {
            result = .success
        }
        return result
    }
}
