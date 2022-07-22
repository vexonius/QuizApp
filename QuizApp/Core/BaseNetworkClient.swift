import Foundation

class BaseNetworkClient: BaseNetworkClientProtocol {

    private var urlSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.protocolClasses = [Interceptor.self]

        return URLSession(configuration: config)
    }()

    private lazy var encoder: JSONEncoder = {
        JSONEncoder()
    }()

    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()

    func get<T: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        responseType: T.Type
    ) async throws -> T {
        let (data, response) = try await urlSession.data(from: url)

        try validateResponse(response: response)

        let responseModel = try decodeResponseBody(type: T.self, data: data)

        return responseModel
    }

    func post<T: Codable, U: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        requestBody: T
    ) async throws -> U {
        let request = try await createRequest(
            method: .post,
            url: url,
            headers: headers,
            params: params,
            requestBody: requestBody)

        let (data, response) = try await URLSession.shared.data(with: request)

        try validateResponse(response: response)

        let responseModel = try decodeResponseBody(type: U.self, data: data)

        return responseModel
    }

    private func createRequest<T: Encodable>(
        method: HttpMethod,
        url: URL,
        headers: [String: String]?,
        params: [String: String]?,
        requestBody: T?
    ) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.string

        headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let requestBody = requestBody {
            guard let encodedBody = try? encodeRequestBody(model: requestBody) else {
                throw NetworkError.bodyFormatError
            }

            request.httpBody = encodedBody
        }

        return request
    }

    private func encodeRequestBody<T: Encodable>(model: T) throws -> Data {
        try encoder.encode(model)
    }

    private func decodeResponseBody<T: Decodable>(type: T.Type, data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }

    private func validateResponse(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else { throw NetworkError.responseCorrupted }

        switch response.statusCode {
        case 200..<300:
            return
        case 400:
            throw ClientError.badRequest
        case 401:
            throw ClientError.unauthorized
        case 403:
            throw ClientError.forbiden
        case 404:
            throw ClientError.notFound
        case 500...:
            throw ClientError.serverError
        default:
            throw ClientError.unknown
        }
    }

}
