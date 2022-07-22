import Foundation

protocol BaseNetworkClientProtocol {

    func get<T: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        responseType: T.Type
    ) async throws -> T

    func post<T: Codable, U: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        requestBody: T
    ) async throws -> U

}
