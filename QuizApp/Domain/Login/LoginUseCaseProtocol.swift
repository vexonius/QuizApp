protocol LoginUseCaseProtocol {

    func login(email: String, password: String) async throws

    func validateToken() async throws

}
