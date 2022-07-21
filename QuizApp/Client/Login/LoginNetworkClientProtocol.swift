protocol LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel

}
