struct QuizSessionResultModel {

    let points: Int

}

extension QuizSessionResultModel {

    init(from model: QuizSessionResultRepoModel) {
        self.init(points: model.points)
    }

}
