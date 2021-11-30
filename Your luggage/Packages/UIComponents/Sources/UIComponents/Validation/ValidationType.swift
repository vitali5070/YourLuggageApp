import UIKit

public enum ValidationType {
    case name
    case phone
    case email
    case password

    private var pattern: String {
        switch self {
        case .name: return "[a-zA-Zа-яА-Я) (_'’-]*"
        case .phone: return "^(\\+)?[0-9 \\-()]*"
        case .email: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case .password: return "[A-Za-z0-9]"
        }
    }

    var lengthValidator: TextValidator {
        switch self {
        case .name: return LengthValidator(min: 2, max: 35)
        case .phone: return LengthValidator(min: 1)
        case .email: return LengthValidator(min: 1)
        case .password: return LengthValidator(min: 6)
        }
    }

    var symbolsValidator: TextValidator {
        switch self {
        case .name: return SymbolsValidator(pattern: pattern)
        case .phone: return SymbolsValidator(pattern: pattern)
        case .email: return SymbolsValidator(pattern: pattern)
        case .password: return SymbolsValidator(pattern: pattern)
        }
    }

    var validators: [TextValidator] {
        switch self {
        case .name: return [lengthValidator, symbolsValidator]
        case .phone: return [lengthValidator, symbolsValidator]
        case .email: return [lengthValidator, symbolsValidator]
        case .password: return [lengthValidator, symbolsValidator]
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .name: return .default
        case .phone: return .phonePad
        case .email: return .emailAddress
        case .password: return .default
        }
    }

    var textContentType: UITextContentType? {
        switch self {
        case .name: return .givenName
        case .phone: return .telephoneNumber
        case .email: return .emailAddress
        case .password: return .password
        }
    }

    var textAutocapitalizationType: UITextAutocapitalizationType {
        switch self {
        case .name: return .words
        case .phone: return .none
        case .email: return .none
        case .password: return .none
        }
    }

    var textSpellCheckingType: UITextSpellCheckingType {
        switch self {
        case .name: return .no
        case .phone: return .no
        case .email: return .no
        case .password: return .no
        }
    }
}
