protocol AccountNetworkClientProtocol {

    func getAccountDetails() async throws -> AccountDetailsNetworkModel

    func updateUsername(requestBody: UsernameUpdateRequestNetworkModel) async throws -> AccountDetailsNetworkModel

}
