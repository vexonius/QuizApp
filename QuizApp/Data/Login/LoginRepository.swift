import Foundation

protocol LoginRepositoryProtocol {

    func login(data: LoginRequestBodyRepoModel) async throws -> LoginResponseRepoModel

}

class LoginRepository: LoginRepositoryProtocol {

    private let networkClient: LoginNetworkClientProtocol

    init(networkClient: LoginNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func login(data: LoginRequestBodyRepoModel) async throws -> LoginResponseRepoModel {
        let requestBody = LoginRequestBodyNetworkModel(from: data)
        let networkModel = try await networkClient.login(requestBody: requestBody)

        return LoginResponseRepoModel(from: networkModel)
    }

}
