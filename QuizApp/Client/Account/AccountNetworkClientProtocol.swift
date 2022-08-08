protocol AccountNetworkClientProtocol {

    var accountDetails: AccountDetailsResponse { get async throws }

    func updateUsername(requestModel: AccountUpdateRequestModel) async throws -> AccountDetailsResponse

}
