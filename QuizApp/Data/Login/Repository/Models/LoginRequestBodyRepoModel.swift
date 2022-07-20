struct LoginRequestBodyRepoModel: Codable {

    let username: String
    let password: String

}

extension LoginRequestBodyRepoModel {

    init(from loginUsecaseModel: LoginRequestBodyModel) {
        self.init(username: loginUsecaseModel.username, password: loginUsecaseModel.password)
    }

}
