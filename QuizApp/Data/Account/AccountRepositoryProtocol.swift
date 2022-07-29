protocol AccountRepositoryProtocol {

    func getAccountDetails() async throws -> AccountDetailsRepoModel

    func updateUsername(data: UsernameUpdateRequestRepoModel) async throws -> Bool

}
