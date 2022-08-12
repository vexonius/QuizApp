struct UserRankingRepoModel {

    let name: String
    let points: Int

}

extension UserRankingRepoModel {

    init(from model: UserRankingResponse) {
        self.init(name: model.name, points: model.points)
    }

}
