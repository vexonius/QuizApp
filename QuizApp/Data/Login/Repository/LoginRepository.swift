import Foundation

class LoginRepository: LoginRepositoryProtocol {

    private let networkClient: LoginNetworkClientProtocol
    private let secureStorage = SecureStorage.shared

    init(networkClient: LoginNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func login(data: LoginRequestBodyRepoModel) async throws {
        let requestBody = LoginRequestBodyNetworkModel(from: data)
        let networkModel = try await networkClient.login(requestBody: requestBody)

        guard !networkModel.accessToken.isEmpty else { throw NetworkError.responseCorrupted }

        saveAccessToken(token: networkModel.accessToken)
        saveUsername(username: data.username)
    }

    func validateToken() async throws {
        try await networkClient.validateToken()
    }

    func logout() async {
        deleteToken()
    }

    private func saveAccessToken(token: String) {
        secureStorage.set(token, for: SecureStorageKey.accessToken)
    }

    private func saveUsername(username: String) {
        secureStorage.set(username, for: SecureStorageKey.username)
    }

    private func deleteToken() {
        secureStorage.delete(SecureStorageKey.accessToken)
    }

}
