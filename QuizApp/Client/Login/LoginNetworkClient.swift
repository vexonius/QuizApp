import Foundation

class LoginNetworkClient: LoginNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel {
        try await baseNetworkClient.post(
            url: LoginEndpoints.login.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: requestBody)
    }

}
