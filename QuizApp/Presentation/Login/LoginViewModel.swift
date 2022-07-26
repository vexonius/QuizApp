import Foundation
import Combine

class LoginViewModel {

    @Published private(set) var isLoginButtonEnabled: Bool = false
    @Published private(set) var isPasswordHidden: Bool = true
    @Published private(set) var errorMessage: String = ""

    private let loginUseCase: LoginUseCaseProtocol
    private let coordinator: AppCoordinatorProtocol

    private var email: String = ""
    private var password: String = ""

    init(loginUseCase: LoginUseCaseProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator

        validateInputs()
    }

    func login() {
        Task(priority: .high) {
            do {
                try await loginUseCase.login(email: email, password: password)
                await MainActor.run { coordinator.routeToHomeScreen() }
            } catch {
                handleLoginResponseError(error: error)
            }

        }
    }

    func togglePasswordVisibility() {
        isPasswordHidden.toggle()
    }

    func onEmailChanged(_ email: String) {
        self.email = email
        validateInputs()
    }

    func onPasswordChanged(_ password: String) {
        self.password = password
        validateInputs()
    }

    private func validateInputs() {
        isLoginButtonEnabled = !email.isEmpty && email.isValid && !password.isEmpty
    }

    private func handleLoginResponseError(error: Error) {
        switch error {
        case ClientError.unauthorized:
            errorMessage = LocalizedStrings.unauthorizedLoginErrorMessage.localizedString
        default:
            errorMessage = LocalizedStrings.serverErrorMessage.localizedString
        }
    }

}
