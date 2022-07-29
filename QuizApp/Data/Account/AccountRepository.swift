class AccountRepository: AccountRepositoryProtocol {

    private let accountNetworkClient: AccountNetworkClientProtocol

    init(accountNetworkClient: AccountNetworkClientProtocol) {
        self.accountNetworkClient = accountNetworkClient
    }

    func getAccountDetails() async throws -> AccountDetailsRepoModel {
        let networkModel = try await accountNetworkClient.getAccountDetails()

        return AccountDetailsRepoModel(from: networkModel)
    }

    func updateUsername(data: UsernameUpdateRequestRepoModel) async throws -> Bool {
        let requestBodyNetworkModel = UsernameUpdateRequestNetworkModel(from: data)
        try await accountNetworkClient.updateUsername(requestBody: requestBodyNetworkModel)

        return true
    }

}
