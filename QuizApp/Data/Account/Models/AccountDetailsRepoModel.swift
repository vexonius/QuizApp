struct AccountDetailsRepoModel {

    let id: Int
    let name: String
    let email: String

}

extension AccountDetailsRepoModel {

    init(from networkModel: AccountDetailsNetworkModel) {
        self.init(id: networkModel.id, name: networkModel.name, email: networkModel.email)
    }
}
