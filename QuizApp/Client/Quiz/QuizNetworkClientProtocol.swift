protocol QuizNetworkClientProtocol {

    var quizzes: [QuizResponse] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizResponse]

    func leaderboard(for quizId: Int) async throws -> [UserRankingResponse]

}
