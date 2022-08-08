protocol AccountNetworkClientProtocol {

    var accountDetails: AccountDetailsResponse { get async throws }

    func updateUsername(requestModel: UsernameUpdateRequestModel) async throws -> AccountDetailsResponse

}
