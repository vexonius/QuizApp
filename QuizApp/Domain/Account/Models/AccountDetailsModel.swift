struct AccountDetailsModel {

    let id: Int
    let usename: String?
    let name: String
    let email: String

}

extension AccountDetailsModel {

    init(from repoModel: AccountDetailsRepoModel) {
        self.init(id: repoModel.id, usename: repoModel.usename, name: repoModel.name, email: repoModel.email)
    }
}
