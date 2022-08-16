struct QuizSessionRepoModel: Decodable {

    let sessionId: String
    let questions: [QuizQuestionRepoModel]

}

extension QuizSessionRepoModel {

    init(from model: QuizSessionResponse) {
        self.init(
            sessionId: model.sessionId,
            questions: model
                .questions
                .map { QuizQuestionRepoModel(from: $0) })
    }

}

struct QuizQuestionRepoModel: Decodable {

    let id: Int
    let correctAnswerId: Int
    let question: String
    let answers: [QuizAnswerRepoModel]

}

extension QuizQuestionRepoModel {

    init(from model: QuizQuestionResponse) {
        self.init(
            id: model.id,
            correctAnswerId: model.correctAnswerId,
            question: model.question,
            answers: model
                .answers
                .map { QuizAnswerRepoModel(from: $0) })
    }

}

struct QuizAnswerRepoModel: Decodable {

    let id: Int
    let answer: String

}

extension QuizAnswerRepoModel {

    init(from model: QuizAnswerResponse) {
        self.init(id: model.id, answer: model.answer)
    }

}
