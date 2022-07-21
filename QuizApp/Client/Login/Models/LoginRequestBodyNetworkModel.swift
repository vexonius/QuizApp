struct LoginRequestBodyNetworkModel: Codable {

    let username: String
    let password: String

}

extension LoginRequestBodyNetworkModel {

    init(from repoModel: LoginRequestBodyRepoModel) {
        self.init(username: repoModel.username, password: repoModel.password)
    }

}
