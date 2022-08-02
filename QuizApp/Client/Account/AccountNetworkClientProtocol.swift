protocol AccountNetworkClientProtocol {

    func getAccountDetails() async throws -> AccountDetailsResponse

    func updateUsername(requestModel: UsernameUpdateRequestModel) async throws -> AccountDetailsResponse

}
