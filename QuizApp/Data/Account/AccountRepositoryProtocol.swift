protocol AccountRepositoryProtocol {

    var accountDetails: AccountDetailsRepoModel { get async throws }

    func updateUsername(data: AccountUpdateRepoModel) async throws -> AccountDetailsRepoModel

}
