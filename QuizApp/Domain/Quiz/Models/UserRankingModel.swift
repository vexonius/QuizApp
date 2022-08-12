struct UserRankingModel {

    let name: String
    let points: Int

}

extension UserRankingModel {

    init(from model: UserRankingRepoModel) {
        self.init(name: model.name, points: model.points)
    }

}
