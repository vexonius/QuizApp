struct QuestionCellModel: AnsweringCellProtocol {

    let cellType: QuizCellType
    let questionText: String
    let answered: Bool?

}

extension QuestionCellModel {

    init(from model: QuizQuestionModel) {
        self.init(cellType: .question, questionText: model.question, answered: false)
    }

}
