class AccountRespository: AccountRespositoryProtocol {

    init() {

    }

    func getAccountDetails() -> AccountDetailsRepoModel {
        AccountDetailsRepoModel(id: 1, usename: "etino", name: "Tino Emer", email: "hello@five.agency")
    }

    func updateUsername(data: UsernameUpdateRequestRepoModel) -> Bool {
        return true
    }

}
