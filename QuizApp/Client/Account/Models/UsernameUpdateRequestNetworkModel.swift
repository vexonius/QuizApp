struct UsernameUpdateRequestNetworkModel: Codable {

    let name: String

}

extension UsernameUpdateRequestNetworkModel {

    init(from repoModel: UsernameUpdateRequestRepoModel) {
        self.init(name: repoModel.name)
    }
}
