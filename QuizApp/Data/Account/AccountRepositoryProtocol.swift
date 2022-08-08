protocol AccountRepositoryProtocol {

    var accountDetails: AccountDetailsRepoModel { get async throws }

    func updateUsername(data: UsernameUpdateRepoModel) async throws -> AccountDetailsRepoModel

}
