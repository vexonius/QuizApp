import Foundation

enum QuizEndpoints {

    private static let baseSubpath = "quiz"
    static let baseEndpoint = Api.apiURL.appendingPathComponent(QuizEndpoints.baseSubpath)

    case quizzes
    case leaderboard

    private var subpath: String {
        switch self {
        case .quizzes:
            return "list"
        case .leaderboard:
            return "leaderboard"
        }
    }

    var path: URL {
        switch self {
        default:
            return QuizEndpoints.baseEndpoint.appendingPathComponent(self.subpath)
        }
    }

}
