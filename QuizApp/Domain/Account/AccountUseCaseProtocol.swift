protocol AccountUseCaseProtocol {

    func getAccountDetails() async throws -> AccountDetailsModel

    func updateUsername(username: String) async throws -> AccountDetailsModel

}
