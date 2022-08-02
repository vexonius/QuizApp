class AccountUseCase: AccountUseCaseProtocol {

    private let accountRepository: AccountRepositoryProtocol

    init(accountRepository: AccountRepositoryProtocol) {
        self.accountRepository = accountRepository
    }

    func getAccountDetails() async throws -> AccountDetailsModel {
        let accountDetailsRepoModel = try await accountRepository.getAccountDetails()

        return AccountDetailsModel(from: accountDetailsRepoModel)
    }

    func updateUsername(username: String) async throws -> AccountDetailsModel {
        let requestData = UsernameUpdateRepoModel(name: username)
        let accountDetailsRepoModel = try await accountRepository.updateUsername(data: requestData)

        return AccountDetailsModel(from: accountDetailsRepoModel)
    }

}
