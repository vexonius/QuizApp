import Foundation

class SettingsViewModel {

    @Published private(set) var currentUsername: String? = ""
    @Published private(set) var errorMessage: String?

    private let accountUseCase: AccountUseCaseProtocol

    init(accountUseCase: AccountUseCaseProtocol) {
        self.accountUseCase = accountUseCase

        fetchUserDetails()
    }

    private func fetchUserDetails() {
        Task {
            do {
                let userInfo = try await accountUseCase.accountDetails
                currentUsername = userInfo.name
            } catch {
                debugPrint(error)
            }
        }
    }
    private func updateUserName(with name: String) {
        Task {
            do {
                let accountDetails = try await accountUseCase.updateUsername(username: name)
                currentUsername = accountDetails.name
            } catch {
                errorMessage = LocalizedStrings.serverErrorMessage.localizedString
            }
        }
    }

    func usernameOnChange(_ newUsername: String) {
        let lastUsername = currentUsername

        guard !newUsername.isEmpty else {
            currentUsername = lastUsername
            return
        }

        updateUserName(with: newUsername)
    }

}
