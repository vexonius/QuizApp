protocol QuizNetworkClientProtocol {

    var quizzes: [QuizResponse] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizResponse]

}
