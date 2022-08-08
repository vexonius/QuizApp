class AccountRepository: AccountRepositoryProtocol {

    private let accountNetworkClient: AccountNetworkClientProtocol

    init(accountNetworkClient: AccountNetworkClientProtocol) {
        self.accountNetworkClient = accountNetworkClient
    }

    var accountDetails: AccountDetailsRepoModel {
        get async throws {
            let networkModel = try await accountNetworkClient.accountDetails

            return AccountDetailsRepoModel(from: networkModel)
        }
    }

    func updateUsername(data: UsernameUpdateRepoModel) async throws -> AccountDetailsRepoModel {
        let accountDetailsResponse = try await accountNetworkClient.updateUsername(requestModel: data.toClientModel())

        return AccountDetailsRepoModel(from: accountDetailsResponse)
    }

}
