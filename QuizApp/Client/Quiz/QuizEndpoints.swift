import Foundation

enum QuizEndpoints: String {

    case quizzes = "quiz/list"

    var path: URL {
        switch self {
        default:
            return Api.apiURL.appendingPathComponent(self.rawValue)
        }
    }

}
