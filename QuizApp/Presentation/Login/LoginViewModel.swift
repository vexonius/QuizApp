import Foundation
import Combine

class LoginViewModel {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginButtonEnabled: Bool = true
    @Published var isPasswordHidden: Bool = true

    init() {
        validateInputs()
    }

    private func validateInputs() {
        guard
            !email.isEmpty,
            !password.isEmpty
        else {
            return isLoginButtonEnabled = false
        }

        isLoginButtonEnabled = true
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
