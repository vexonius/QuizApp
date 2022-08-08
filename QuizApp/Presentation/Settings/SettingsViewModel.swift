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

    private func update(name: String) {
        Task {
            do {
                let accountDetails = try await accountUseCase.update(name: name)
                currentUsername = accountDetails.name
            } catch {
                errorMessage = LocalizedStrings.serverErrorMessage.localizedString
            }
        }
    }

    func nameOnChange(_ newName: String) {
        let lastUsername = currentUsername

        guard !newName.isEmpty else {
            currentUsername = lastUsername
            return
        }

        update(name: newName)
    }

}
