protocol AccountUseCaseProtocol {

    var accountDetails: AccountDetailsModel { get async throws }

    func update(name: String) async throws -> AccountDetailsModel

}
