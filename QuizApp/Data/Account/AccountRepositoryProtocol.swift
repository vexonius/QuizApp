protocol AccountRepositoryProtocol {

    func getAccountDetails() async throws -> AccountDetailsRepoModel

    func updateUsername(data: UsernameUpdateRepoModel) async throws -> AccountDetailsRepoModel

}
