struct QuestionCellModel {

    let questionText: String
    let answered: Bool?

}

extension QuestionCellModel {

    init(from model: QuizQuestionModel) {
        self.init(questionText: model.question, answered: false)
    }

}
