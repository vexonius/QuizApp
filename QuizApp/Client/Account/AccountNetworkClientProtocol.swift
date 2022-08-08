protocol AccountNetworkClientProtocol {

    var accountDetails: AccountDetailsResponse { get async throws }

    func update(request: AccountUpdateRequestModel) async throws -> AccountDetailsResponse

}
