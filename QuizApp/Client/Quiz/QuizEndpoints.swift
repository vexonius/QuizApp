import Foundation

enum QuizEndpoints {

    private static let baseSubpath = "quiz"
    static let baseEndpoint = Api.apiURL.appendingPathComponent(QuizEndpoints.baseSubpath)

    case quizzes
    case leaderboard
    case startSession(id: Int)
    case endSession(id: String)

    private var subpath: String {
        switch self {
        case .quizzes:
            return "list"
        case .leaderboard:
            return "leaderboard"
        case let .startSession(id):
            return "\(id)/session/start"
        case let .endSession(id):
            return "session/\(id)/end"
        }
    }

    var path: URL {
        switch self {
        default:
            return QuizEndpoints.baseEndpoint.appendingPathComponent(self.subpath)
        }
    }

}
