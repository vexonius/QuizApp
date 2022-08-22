struct QuizSessionResultRepoModel: Decodable {

    let points: Int

}

extension QuizSessionResultRepoModel {

    init(from model: QuizSessionResultResponse) {
        self.init(points: model.points)
    }

}
