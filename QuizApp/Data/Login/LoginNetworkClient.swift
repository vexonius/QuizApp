import Foundation

enum LoginEndpoints: String {

    case login

    var path: URL {
        switch self {
        case .login:
            return BaseNetworkClient.baseApiUrl.appendingPathComponent(self.rawValue)
        }
    }

}

protocol LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel

}

class LoginNetworkClient {

    private let baseNetworkClient: BaseNetworkClientProvider

    init(baseNetworkClient: BaseNetworkClientProvider) {
        self.baseNetworkClient = baseNetworkClient
    }

}

extension LoginNetworkClient: LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel {
        try await baseNetworkClient.post(
            url: LoginEndpoints.login.path,
            params: [:],
            headers: ["Content-Type": "application/json"],
            requestBody: requestBody)
    }

}
