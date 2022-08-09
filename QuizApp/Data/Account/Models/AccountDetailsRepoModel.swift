struct AccountDetailsRepoModel {

    let id: Int
    let name: String
    let email: String

}

extension AccountDetailsRepoModel {

    init(from responseModel: AccountDetailsResponse) {
        self.init(id: responseModel.id, name: responseModel.name, email: responseModel.email)
    }

}
