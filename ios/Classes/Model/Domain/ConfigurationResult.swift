import Foundation

struct ConfigurationResult: Encodable {

    // MARK: - Constants

    private enum Constant {
        static let configurationSuccess = "configurationSuccess"
        static let configurationFailure = "configurationFailure"
        static let paymentCompleted = "paymentCompleted"
        static let paymentCancelled = "paymentCancelled"
        static let paymentError = "paymentError"
        static let tokenPaymentCompleted = "tokenPaymentCompleted"
        static let tokenPaymentCancelled = "tokenPaymentCancelled"
        static let tokenPaymentError = "tokenPaymentError"
        static let tokenizationCompleted = "tokenizationCompleted"
        static let tokenizationCancelled = "tokenizationCancelled"
        static let unknownHandleMethod = "unknownHandleMethod"
    }

    // MARK: - Properties

    let type: String
    let value: String?

    // MARK: - Results

    static func configurationValid() -> ConfigurationResult {
        return .init(type: Constant.configurationSuccess, value: nil)
    }

    static func configurationFailure() -> ConfigurationResult {
        return .init(type: Constant.configurationFailure, value: nil)
    }

    static func configurationFailure(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.configurationFailure, error: error)
    }

    static func paymentCompleted(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.paymentCompleted, value: transactionId)
    }

    static func paymentCancelled(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.paymentCancelled, value: transactionId)
    }

    static func payment(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.paymentError, error: error)
    }

    static func tokenPaymentCompleted(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.tokenPaymentCompleted, value: transactionId)
    }

    static func tokenPaymentCancelled(transactionId: String) -> ConfigurationResult {
        return .init(type: Constant.tokenPaymentCancelled, value: transactionId)
    }

    static func tokenPayment(error: Error) -> ConfigurationResult {
        return .errorResult(type: Constant.tokenPaymentError, error: error)
    }

    static func tokenizationCompleted() -> ConfigurationResult {
        return .init(type: Constant.tokenizationCompleted, value: nil)
    }

    static func tokenizationCancelled() -> ConfigurationResult {
        return .init(type: Constant.tokenizationCancelled, value: nil)
    }

    static func unknownHandleMethod() -> ConfigurationResult {
        return .init(type: Constant.unknownHandleMethod, value: nil)
    }

    // MARK: - Private

    private static func errorResult(type: String, error: Error) -> ConfigurationResult {
        .init(type: type, value: "\(error)")
    }
}

// MARK: - Extensions

extension ConfigurationResult {

    func toJson() -> String {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            debugPrint("Error converting ConfigurationResult to JSON: \(error)")
        }
        return ""
    }
}
