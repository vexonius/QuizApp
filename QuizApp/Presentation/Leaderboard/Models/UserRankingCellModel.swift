struct UserRankingCellModel {

    let position: String
    let name: String
    let points: String

}

extension UserRankingCellModel {

    init(position: Int, model: UserRankingModel) {
        self.init(
            position: "\(position).",
            name: model.name,
            points: model.points.string)
    }

}
