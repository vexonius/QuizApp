import Foundation

class LoginRepository: LoginRepositoryProtocol {

    private let networkClient: LoginNetworkClientProtocol
    private let secureStorage = SecureStorage.shared

    init(networkClient: LoginNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func login(data: LoginRequestBodyRepoModel) async throws -> LoginResponseRepoModel {
        let requestBody = LoginRequestBodyNetworkModel(from: data)
        let networkModel = try await networkClient.login(requestBody: requestBody)

        guard !networkModel.accessToken.isEmpty else { throw NetworkError.responseCorrupted }

        saveAccessToken(token: networkModel.accessToken)

        return LoginResponseRepoModel(from: networkModel)
    }

    private func saveAccessToken(token: String) {
        secureStorage.set(token, forKey: SecureStorageKey.accessToken)
    }

}
