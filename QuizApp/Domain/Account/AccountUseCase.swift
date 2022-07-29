class AccountUseCase: AccountUseCaseProtocol {

    private let accountRepository: AccountRespositoryProtocol

    init(accountRepository: AccountRespositoryProtocol) {
        self.accountRepository = accountRepository
    }

    func getAccountDetails() async throws -> AccountDetailsModel {
        let accountDetailsRepoResponse = try await accountRepository.getAccountDetails()

        return AccountDetailsModel(from: accountDetailsRepoResponse)
    }

    func updateUsername(username: String) async throws -> Bool {
        let requestData = UsernameUpdateRequestRepoModel(username: username)
        let isUpdateSuccessful = accountRepository.updateUsername(data: requestData)

        return isUpdateSuccessful
    }

}
