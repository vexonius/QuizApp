struct QuizQuestionsRepoModel: Decodable {

    let sessionId: String
    let questions: [QuestionRepoModel]

}

extension QuizQuestionsRepoModel {

    init(from model: QuizQuestionsResponse) {
        self.init(
            sessionId: model.sessionId,
            questions: model
                .questions
                .map { QuestionRepoModel(from: $0) })
    }

}

struct QuestionRepoModel: Decodable {

    let id: Int
    let correctAnswerId: Int
    let question: String
    let answers: [AnswerRepoModel]

}

extension QuestionRepoModel {

    init(from model: QuestionResponse) {
        self.init(
            id: model.id,
            correctAnswerId: model.correctAnswerId,
            question: model.question,
            answers: model
                .answers
                .map { AnswerRepoModel(from: $0) })
    }

}

struct AnswerRepoModel: Decodable {

    let id: Int
    let answer: String

}

extension AnswerRepoModel {

    init(from model: AnswerResponse) {
        self.init(id: model.id, answer: model.answer)
    }

}
