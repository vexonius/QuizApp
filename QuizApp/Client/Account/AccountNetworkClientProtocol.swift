protocol AccountNetworkClientProtocol {

    func getAccountDetails() async throws -> AccountDetailsResponse

    func updateUsername(requestBody: UsernameUpdateRequestModel) async throws -> AccountDetailsResponse

}
