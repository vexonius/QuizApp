import Foundation

enum LoginEndpoints: String {

    case login
    case validateToken = "check"

    var path: URL {
        switch self {
        default :
            return Api.apiURL.appendingPathComponent(self.rawValue)
        }
    }

}
