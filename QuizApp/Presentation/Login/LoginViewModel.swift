import Foundation
import Combine

class LoginViewModel {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginButtonEnabled: Bool = true
    @Published var isPasswordHidden: Bool = true

    init() {
        observeInputs()
    }

    func login() {
        guard !username.isEmpty && !password.isEmpty else { return }

        // Login logic to be implemented
    }

    func togglePasswordVisibility() {
        isPasswordHidden.toggle()
    }

    func observeInputs() {
        guard
            !username.isEmpty,
            !password.isEmpty
        else {
            return isLoginButtonEnabled = false
        }

        isLoginButtonEnabled = true
    }

}
