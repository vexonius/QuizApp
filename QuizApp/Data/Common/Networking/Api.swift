struct Api {

    static let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api/"
    static let currentApiVersion = "v1"
    static let JWTtokenFormat = "Bearer %@"

    static var fullUrl: String {
        baseUrl + currentApiVersion
    }

}
