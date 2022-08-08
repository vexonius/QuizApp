class AccountUseCase: AccountUseCaseProtocol {

    private let accountRepository: AccountRepositoryProtocol

    init(accountRepository: AccountRepositoryProtocol) {
        self.accountRepository = accountRepository
    }

    var accountDetails: AccountDetailsModel {
        get async throws {
            let accountDetailsRepoModel = try await accountRepository.accountDetails

            return AccountDetailsModel(from: accountDetailsRepoModel)
        }
    }

    func update(name: String) async throws -> AccountDetailsModel {
        let requestModel = AccountUpdateRepoModel(name: name)
        let accountDetailsRepoModel = try await accountRepository.update(request: requestModel)

        return AccountDetailsModel(from: accountDetailsRepoModel)
    }

}
