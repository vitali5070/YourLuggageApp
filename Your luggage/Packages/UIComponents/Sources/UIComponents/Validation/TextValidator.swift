import Foundation

public protocol TextValidator {
    func validate(text: String?) -> ValidationResult
}

public enum ValidationResult {
    case success
    case failed(error: ValidationError)
    
    public var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }
}

public enum ValidationError: Error {
    case other(Error)
    case incorrectLength
    case forbiddenСharacter
    case templateMismatch
    case multi([ValidationError])
    case invalidEmail
    case invalidPhone
    case invalidPassword
    case invalidPasswordLength
    case invalidNameLength
    case invalidNameSymbols
    case invalidPasswordSymbols
    case spacesOnly
    
public var localizedString: String {
        switch self {
        case .other(let error): return error.localizedDescription
        case .incorrectLength: return "неправильная длина"
        case .forbiddenСharacter: return "содержит недопустимый символ"
        case .templateMismatch: return "ошибка"
        case .multi(let errors): return errors.map { $0.localizedString }.joined(separator: "\n")
        case .invalidEmail: return "неправильный Email"
        case .invalidPhone: return "неправильный телефон"
        case .invalidPassword: return "неправильный пароль"
        case .invalidNameLength: return "неправильная длина"
        case .invalidPasswordLength: return "неправильная длина пароля. Введите не менее шести символов."
        case .invalidNameSymbols: return "неправильный символ"
        case .invalidPasswordSymbols: return "неправильный символ"
        case .spacesOnly: return "не может состоять из пробелов"
        }
    }
}
