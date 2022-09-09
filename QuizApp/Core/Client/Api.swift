import Foundation

struct Api {

    static let baseURL = "https://five-ios-quiz-app.herokuapp.com/api/"
    static let currentApiVersion = "v1"
    static let JWTTokenFormat = "Bearer %@"

    static var apiPath: String {
        baseURL + currentApiVersion
    }

    static var apiURL: URL {
        var url = URL(string: baseURL)!
        url.appendPathComponent(currentApiVersion)

        return url
    }

}
