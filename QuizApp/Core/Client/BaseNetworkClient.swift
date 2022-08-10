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

    func get<T: Decodable>(
        url: URL,
        params: [String: String],
        headers: [String: String]
    ) async throws -> T {
        let request = try await createRequest(
            method: .get,
            url: url,
            headers: headers,
            params: params)

        let (data, response) = try await urlSession.data(with: request)

        try validateResponse(response: response)

        let responseModel = try decodeResponseBody(type: T.self, data: data)

        return responseModel
    }

    func post<T: Encodable, U: Decodable>(
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

        let (data, response) = try await urlSession.data(with: request)

        try validateResponse(response: response)

        let responseModel = try decodeResponseBody(type: U.self, data: data)

        return responseModel
    }

    func patch<T: Encodable, U: Decodable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        requestBody: T
    ) async throws -> U {
        let request = try await createRequest(
            method: .patch,
            url: url,
            headers: headers,
            params: params,
            requestBody: requestBody)

        let (data, response) = try await urlSession.data(with: request)

        try validateResponse(response: response)

        let responseModel = try decodeResponseBody(type: U.self, data: data)

        return responseModel
    }

    func head(url: URL, params: [String: String], headers: [String: String]) async throws {
        let request = try await createRequest(
            method: .head,
            url: url,
            headers: headers,
            params: params)

        let (_, response) = try await urlSession.data(with: request)

        try validateResponse(response: response)
    }

    private func createRequest<T: Encodable>(
        method: HttpMethod,
        url: URL,
        headers: [String: String],
        params: [String: String],
        requestBody: T?
    ) async throws -> URLRequest {
        var request = URLRequest(url: url.appending(queryItems: params))
        request.httpMethod = method.string
        request.append(headers: headers)

        if let requestBody = requestBody {
            guard let encodedBody = try? encodeRequestBody(model: requestBody) else {
                throw NetworkError.bodyFormatError
            }

            request.httpBody = encodedBody
        }

        return request
    }

    private func createRequest(
        method: HttpMethod,
        url: URL,
        headers: [String: String],
        params: [String: String]
    ) async throws -> URLRequest {
        var request = URLRequest(url: url.appending(queryItems: params))
        request.httpMethod = method.string
        request.append(headers: headers)

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
        case 402, 405..<500:
            throw ClientError.unknown
        case 500...:
            throw ClientError.serverError
        default:
            throw ClientError.unknown
        }
    }

}
