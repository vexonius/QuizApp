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

    func update(request: AccountUpdateRepoModel) async throws -> AccountDetailsRepoModel {
        let accountDetailsResponse = try await accountNetworkClient.update(request: request.toClientModel())

        return AccountDetailsRepoModel(from: accountDetailsResponse)
    }

}
