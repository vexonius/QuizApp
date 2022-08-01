import Foundation
import KeychainSwift

struct SecureStorageKey {

    static let accessToken = "access_token"
    static let username = "username"

}

class SecureStorage: SecureStorageProtocol {

    static let shared = SecureStorage()

    private let storage = KeychainSwift()

    private init() {}

    func get(_ key: String) -> String? {
        storage.get(key)
    }

    func get(_ key: String) -> Bool? {
        storage.getBool(key)
    }

    func get(_ key: String) -> Data? {
        storage.getData(key)
    }

    func set(_ value: String, for key: String) {
        storage.set(value, forKey: key)
    }

    func set(_ value: Bool, for key: String) {
        storage.set(value, forKey: key)
    }

    func set(_ value: Data, for key: String) {
        storage.set(value, forKey: key)
    }

    func delete(_ key: String) {
        storage.delete(key)
    }

    func clear() {
        storage.clear()
    }

}
