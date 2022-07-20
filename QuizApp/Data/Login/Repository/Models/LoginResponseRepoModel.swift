struct LoginResponseRepoModel {

    let accessToken: String

}

extension LoginResponseRepoModel {

    init(from networkModel: LoginResponseNetworkModel) {
        self.init(accessToken: networkModel.accessToken)
    }

}
