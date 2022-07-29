import Foundation

enum AccountEndpoints: String {

    case account

    var path: URL {
        switch self {
        default :
            return Api.apiURL.appendingPathComponent(self.rawValue)
        }
    }

}
