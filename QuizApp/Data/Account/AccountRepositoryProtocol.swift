protocol AccountRepositoryProtocol {

    var accountDetails: AccountDetailsRepoModel { get async throws }

    func update(request: AccountUpdateRepoModel) async throws -> AccountDetailsRepoModel

}
