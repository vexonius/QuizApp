struct AccountUpdateRepoModel {

    let name: String

    func toClientModel() -> AccountUpdateRequestModel {
        AccountUpdateRequestModel(name: name)
    }

}
