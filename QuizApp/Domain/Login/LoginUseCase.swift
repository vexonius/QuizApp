import Foundation

class LoginUseCase: LoginUseCaseProtocol {

    private let loginRepository: LoginRepositoryProtocol

    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }

    func login(email: String, password: String) async throws {
        let loginBodyModel = LoginRequestBodyModel(username: email, password: password)

        try await loginRepository.login(data: LoginRequestBodyRepoModel(from: loginBodyModel))
    }

    func validateToken() async throws {
        try await loginRepository.validateToken()
    }

    func logout() async {
        await loginRepository.logout()
    }

}
