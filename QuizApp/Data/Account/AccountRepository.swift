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
        let accountDetailsResponse = try await accountNetworkClient.updateUsername(requestModel: data.toClientModel())

        return AccountDetailsRepoModel(from: accountDetailsResponse)
    }

}
