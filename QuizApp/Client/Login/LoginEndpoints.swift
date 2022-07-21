import Foundation

enum LoginEndpoints: String {

    case login

    var path: URL {
        switch self {
        case .login:
            return Api.apiURL.appendingPathComponent(self.rawValue)
        }
    }

}
