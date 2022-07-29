import Foundation

class SettingsViewModel {

    @Published private(set) var currentUsername: String? = ""

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase
    }

    func usernameOnChange(_ newUsername: String) {
        let lastUsername = currentUsername

        guard !newUsername.isEmpty else {
            return currentUsername = lastUsername
        }

        currentUsername = newUsername
    }

}
