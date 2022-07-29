struct AccountDetailsModel {

    let id: Int
    let name: String
    let email: String

}

extension AccountDetailsModel {

    init(from repoModel: AccountDetailsRepoModel) {
        self.init(id: repoModel.id, name: repoModel.name, email: repoModel.email)
    }
}
