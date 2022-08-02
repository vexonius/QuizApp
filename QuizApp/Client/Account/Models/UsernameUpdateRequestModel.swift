struct UsernameUpdateRequestModel: Encodable {

    let name: String

    func toModel() -> UsernameUpdateRepoModel {
        UsernameUpdateRepoModel(name: name)
    }

}

extension UsernameUpdateRequestModel {

    init(from repoModel: UsernameUpdateRepoModel) {
        self.init(name: repoModel.name)
    }
}
