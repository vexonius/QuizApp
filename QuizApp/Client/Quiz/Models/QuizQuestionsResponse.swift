struct QuizQuestionsResponse: Decodable {

    let sessionId: Int
    let questions: [QuestionResponse]

}

struct QuestionResponse: Decodable {

    let id: Int
    let correctAnswerId: Int
    let question: String
    let answers: [AnswerResponse]

}

struct AnswerResponse: Decodable {

    let id: Int
    let answer: String

}
