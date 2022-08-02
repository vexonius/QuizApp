class AccountRepository: AccountRepositoryProtocol {

    private let accountNetworkClient: AccountNetworkClientProtocol

    init(accountNetworkClient: AccountNetworkClientProtocol) {
        self.accountNetworkClient = accountNetworkClient
    }

    func getAccountDetails() async throws -> AccountDetailsRepoModel {
        let networkModel = try await accountNetworkClient.getAccountDetails()

        return AccountDetailsRepoModel(from: networkModel)
    }

    func updateUsername(data: UsernameUpdateRepoModel) async throws -> AccountDetailsRepoModel {
        let requestBodyNetworkModel = UsernameUpdateRequestModel(from: data)
        let accountDetailsResponse = try await accountNetworkClient.updateUsername(requestBody: requestBodyNetworkModel)

        return AccountDetailsRepoModel(from: accountDetailsResponse)
    }

}
