struct QuizSessionResponse: Decodable {

    let sessionId: String
    let questions: [QuizQuestionResponse]

}

struct QuizQuestionResponse: Decodable {

    let id: Int
    let correctAnswerId: Int
    let question: String
    let answers: [QuizAnswerResponse]

}

struct QuizAnswerResponse: Decodable {

    let id: Int
    let answer: String

}
