import Foundation

class AccountNetworkClient: AccountNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    func getAccountDetails() async throws -> AccountDetailsResponse {
        try await baseNetworkClient.get(
            url: AccountEndpoints.account.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

    func updateUsername(requestBody: UsernameUpdateRequestModel) async throws -> AccountDetailsResponse {
        try await baseNetworkClient.patch(
            url: AccountEndpoints.account.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: requestBody)
    }

}
