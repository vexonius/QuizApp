import Foundation

enum Api {

    static let baseURL = "https://five-ios-quiz-app.herokuapp.com/api/"
    static let currentApiVersion = "v1"
    static let JWTtokenFormat = "Bearer %@"

    static var apiPath: String {
        baseURL + currentApiVersion
    }

    static var apiURL: URL {
        var url = URL(string: baseURL)!
        url.appendPathComponent(currentApiVersion)

        return url
    }

}
