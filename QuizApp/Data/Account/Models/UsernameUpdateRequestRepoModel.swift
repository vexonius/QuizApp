struct UsernameUpdateRepoModel {

    let name: String

    func toClientModel() -> UsernameUpdateRequestModel {
        UsernameUpdateRequestModel(name: name)
    }

}
