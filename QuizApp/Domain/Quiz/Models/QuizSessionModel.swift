struct QuizSessionModel {

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

struct QuizQuestionModel {

    let id: Int
    let question: String
    let answers: [QuizAnswerModel]

}

extension QuizQuestionModel {

    init(from model: QuizQuestionRepoModel) {
        self.init(
            id: model.id,
            question: model.question,
            answers: model
                .answers
                .map { answer in
                    let isCorrect = answer.id == model.correctAnswerId
                    let answerModel = QuizAnswerModel(id: answer.id, isCorrect: isCorrect, answer: answer.answer)

                    return answerModel
                })
    }

}

enum AnsweredResult {

    case unanswered
    case correct
    case `false`

}

struct QuizAnswerModel {

    let id: Int
    let isCorrect: Bool
    let answer: String

}
