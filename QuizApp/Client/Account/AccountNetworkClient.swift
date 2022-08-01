import Foundation

class AccountNetworkClient: AccountNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    func getAccountDetails() async throws -> AccountDetailsNetworkModel {
        try await baseNetworkClient.get(
            url: AccountEndpoints.account.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            responseType: AccountDetailsNetworkModel.self)
    }

    func updateUsername(requestBody: UsernameUpdateRequestNetworkModel) async throws -> Bool {
        try await baseNetworkClient.patch(
            url: AccountEndpoints.account.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: requestBody)
    }

}
