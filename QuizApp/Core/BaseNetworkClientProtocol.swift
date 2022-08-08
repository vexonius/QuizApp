import Foundation

protocol BaseNetworkClientProtocol {

    func get<T: Decodable>(
        url: URL,
        params: [String: String],
        headers: [String: String]
    ) async throws -> T

    func post<T: Encodable, U: Decodable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        requestBody: T
    ) async throws -> U

    func patch<T: Encodable, U: Decodable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        requestBody: T
    ) async throws -> U

    func head(url: URL, params: [String: String], headers: [String: String]) async throws

}
