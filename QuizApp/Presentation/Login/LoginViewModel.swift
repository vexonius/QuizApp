import Foundation
import Combine

class LoginViewModel {

    @Published private (set) var isLoginButtonEnabled: Bool = false
    @Published private (set) var isPasswordHidden: Bool = true

    private let loginUseCase: LoginUseCaseProtocol
    private let coordinator: AppCoordinatorProtocol

    private var email: String = ""
    private var password: String = ""

    init(loginUseCase: LoginUseCaseProtocol, coordinator: AppCoordinatorProtocol) {
        self.loginUseCase = loginUseCase
        self.coordinator = coordinator

        validateInputs()
    }

    private func validateInputs() {
        isLoginButtonEnabled = !email.isEmpty && !password.isEmpty
    }

    func login() {
        guard !email.isEmpty && !password.isEmpty else { return }

        Task(priority: .high) {
            do {
                try await loginUseCase.login(email: email, password: password)
                await MainActor.run { coordinator.routeToHomeScreen() }
            } catch {

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

}
