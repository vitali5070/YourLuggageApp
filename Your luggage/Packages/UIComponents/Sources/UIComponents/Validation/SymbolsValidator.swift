import Foundation

class SymbolsValidator: TextValidator {
    let pattern: String

    init(pattern: String) {
        self.pattern = pattern
    }

    private func validateContainingSymbols(text: String?) -> Bool {
        if let text = text, !pattern.isEmpty {
            let nameTest = NSPredicate(format: "SELF MATCHES %@", pattern)
            return nameTest.evaluate(with: text)
        }
        return true
    }

    func validate(text: String?) -> ValidationResult {
        if validateContainingSymbols(text: text) {
            return .success
        } else {
            return .failed(error: .forbiddenСharacter)
        }
    }
}
