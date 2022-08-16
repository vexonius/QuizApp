protocol QuizRepositoryProtocol {

    var quizzes: [QuizRepoModel] { get async throws }

    func getQuizzes(for category: String) async throws -> [QuizRepoModel]

    func getLeaderboard(for quizId: Int)  async throws -> [UserRankingRepoModel]

}
