struct QuizSessionModel: Decodable {

    let sessionId: String
    let questions: [QuizQuestionModel]

}

extension QuizSessionModel {

    init(from model: QuizSessionRepoModel) {
        self.init(
            sessionId: model.sessionId,
            questions: model
                .questions
                .map { QuizQuestionModel(from: $0) })
    }

}

struct QuizQuestionModel: Decodable {

    let id: Int
    let correctAnswerId: Int
    let question: String
    let answers: [QuizAnswerModel]

}

extension QuizQuestionModel {

    init(from model: QuizQuestionRepoModel) {
        self.init(
            id: model.id,
            correctAnswerId: model.correctAnswerId,
            question: model.question,
            answers: model
                .answers
                .map { QuizAnswerModel(from: $0) })
    }

}

struct QuizAnswerModel: Decodable {

    let id: Int
    let answer: String

}

extension QuizAnswerModel {

    init(from model: QuizAnswerRepoModel) {
        self.init(id: model.id, answer: model.answer)
    }

}
