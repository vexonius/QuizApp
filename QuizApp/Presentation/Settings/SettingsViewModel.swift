import Foundation

class SettingsViewModel {

    @Published private(set) var currentUsername: String? = ""
    @Published private(set) var errorMessage: String?

    private let accountUseCase: AccountUseCaseProtocol
    private let loginUseCase: LoginUseCaseProtocol
    private let coordinator: AppCoordinatorProtocol

    init(
        accountUseCase: AccountUseCaseProtocol,
        loginUsecase: LoginUseCaseProtocol,
        coordinator: AppCoordinatorProtocol
    ) {
        self.accountUseCase = accountUseCase
        self.loginUseCase = loginUsecase
        self.coordinator = coordinator

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

    func logout() {
        Task {
            await loginUseCase.logout()
            await MainActor.run { coordinator.routeToLogin() }
        }
    }

}
