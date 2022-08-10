class AccountNetworkClient: AccountNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    var accountDetails: AccountDetailsResponse {
        get async throws {
            try await baseNetworkClient.get(
                url: AccountEndpoints.account.path,
                params: [:],
                headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
        }
    }

    func update(request: AccountUpdateRequestModel) async throws -> AccountDetailsResponse {
        try await baseNetworkClient.patch(
            url: AccountEndpoints.account.path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: request)
    }

}
