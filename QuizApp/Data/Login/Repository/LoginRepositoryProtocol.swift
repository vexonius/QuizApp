protocol LoginRepositoryProtocol {

    func login(data: LoginRequestBodyRepoModel) async throws

    func validateToken() async throws

}
