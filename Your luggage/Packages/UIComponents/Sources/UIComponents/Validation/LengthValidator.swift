import Foundation

class LengthValidator: TextValidator {
    let min: Int
    let max: Int

    public init(min: Int = 0, max: Int = Int.max) {
        self.min = min
        self.max = max
    }

    fileprivate func validateLength(text: String?) -> Bool {
        if let text = text?.trimmed, text.count >= min, text.count <= max {
            return true
        }
        return false
    }

    func validate(text: String?) -> ValidationResult {
        if validateLength(text: text) {
            return .success
        } else {
            return text?.trimmed.isEmpty == true ? .failed(error: .spacesOnly) : .failed(error: .incorrectLength)
        }
    }
}

extension String {
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
