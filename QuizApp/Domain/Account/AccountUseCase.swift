class AccountUseCase: AccountUseCaseProtocol {

    private let accountRepository: AccountRepositoryProtocol

    init(accountRepository: AccountRepositoryProtocol) {
        self.accountRepository = accountRepository
    }

    func getAccountDetails() async throws -> AccountDetailsModel {
        let accountDetailsRepoResponse = try await accountRepository.getAccountDetails()

        return AccountDetailsModel(from: accountDetailsRepoResponse)
    }

    func updateUsername(username: String) async throws -> AccountDetailsModel {
        let requestData = UsernameUpdateRequestRepoModel(name: username)
        let accountDetailsRepoModel = try await accountRepository.updateUsername(data: requestData)

        return AccountDetailsModel.init(from: accountDetailsRepoModel)
    }

}
