extension LoginViewModel {

    func onEmailChanged(_ email: String) {
        self.email = email
        validateInputs()
    }

    func onPasswordChanged(_ password: String) {
        self.password = password
        validateInputs()
    }

}
