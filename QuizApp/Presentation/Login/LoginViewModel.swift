import Foundation
import Combine

class LoginViewModel {

    @Published private (set) var isLoginButtonEnabled: Bool = false
    @Published private (set) var isPasswordHidden: Bool = true

    private var loginUseCase: LoginUseCaseProtocol

    private var email: String = ""
    private var password: String = ""

    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase

        validateInputs()
    }

    private func validateInputs() {
        isLoginButtonEnabled = !email.isEmpty && !password.isEmpty
    }

    func login() {
        guard !email.isEmpty && !password.isEmpty else { return }

        // Login logic to be implemented
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
