protocol LoginNetworkClientProtocol {

    func login(requestBody: LoginRequestBodyNetworkModel) async throws -> LoginResponseNetworkModel

    func validateToken() async throws

}
