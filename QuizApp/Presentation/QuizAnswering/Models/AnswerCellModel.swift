struct AnswerCellModel: AnsweringCellProtocol {

    let cellType: QuizCellType
    let answerText: String
    let isCorrect: Bool

}

extension AnswerCellModel {

    init(from model: QuizAnswerModel) {
        self.init(cellType: .answer, answerText: model.answer, isCorrect: model.isCorrect)
    }

}
