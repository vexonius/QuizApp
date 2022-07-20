import Foundation

enum LoginEndpoints: String {

    case login

    var path: URL {
        switch self {
        case .login:
            return Api.apiURL.appendingPathComponent(self.rawValue)
        }
    }

}

protocol LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel

}

class LoginNetworkClient {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

}

extension LoginNetworkClient: LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel {
        try await baseNetworkClient.post(
            url: LoginEndpoints.login.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: requestBody)
    }

}
