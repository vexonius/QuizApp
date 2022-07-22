protocol LoginRepositoryProtocol {

    func login(data: LoginRequestBodyRepoModel) async throws -> Bool

}
