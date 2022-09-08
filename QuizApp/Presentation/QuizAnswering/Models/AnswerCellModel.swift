struct AnswerCellModel: Equatable, Hashable {

    let answerText: String
    let isCorrect: Bool

}

extension AnswerCellModel {

    init(from model: QuizAnswerModel) {
        self.init(answerText: model.answer, isCorrect: model.isCorrect)
    }

}
