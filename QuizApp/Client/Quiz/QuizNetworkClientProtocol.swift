protocol QuizNetworkClientProtocol {

    var quizzes: [QuizResponse] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizResponse]

    func getLeaderboard(for quizId: Int) async throws -> [UserRankingResponse]

    func startQuiz(with id: Int) async throws -> QuizSessionResponse

    func endQuiz(for sessionId: String, with request: QuizResultRequest) async throws -> QuizSessionResultResponse

}
