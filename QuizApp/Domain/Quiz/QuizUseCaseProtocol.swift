protocol QuizUseCaseProtocol {

    var quizzes: [QuizModel] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizModel]

    func getLeaderboard(for quizId: Int) async throws -> [UserRankingModel]

}
