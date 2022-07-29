protocol AccountRespositoryProtocol {

    func getAccountDetails() -> AccountDetailsRepoModel

    func updateUsername(data: UsernameUpdateRequestRepoModel) -> Bool

}
