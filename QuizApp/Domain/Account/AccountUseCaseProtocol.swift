protocol AccountUseCaseProtocol {

    var accountDetails: AccountDetailsModel { get async throws }

    func updateUsername(username: String) async throws -> AccountDetailsModel

}
