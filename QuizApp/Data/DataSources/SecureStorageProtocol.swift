import Foundation

protocol SecureStorageProtocol {

    func get(_ key: String) -> String?

    func get(_ key: String) -> Bool?

    func get(_ key: String) -> Data?

    func set(_ value: String, for key: String)

    func set(_ value: Bool, for key: String)

    func set(_ value: Data, for key: String)

    func delete(_ key: String)

    func clear()

}
