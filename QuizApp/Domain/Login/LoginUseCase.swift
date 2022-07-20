import Foundation

protocol LoginUseCaseProtocol {

    func login(email: String, password: String) async throws

}

class LoginUseCase: LoginUseCaseProtocol {

    private let loginRepository: LoginRepositoryProtocol

    init(loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
    }

    func login(email: String, password: String) async throws {
        let loginBodyModel = LoginRequestBodyModel(username: email, password: password)

        let response = try await loginRepository.login(data: LoginRequestBodyRepoModel(from: loginBodyModel))
        dump(response)
    }

}
