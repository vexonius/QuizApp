import KeychainSwift

struct SecureStorageKey {

    static let accessToken = "access_token"

}

class SecureStorage {

    static let shared = KeychainSwift()

    private init() {}

}
