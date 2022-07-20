import Foundation

enum HttpMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

}

enum NetworkError: Error {

    case badURL
    case bodyFormatError
    case responseCorrupted

}

enum NetworkResponseStatus: Int {

    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case forbiden = 403
    case notFound = 404
    case serverError = 500

}

enum ClientError: Error {

    case badRequest
    case unauthorized
    case forbiden
    case notFound
    case serverError
    case unknown

}

enum HeaderField: String {

    case authorization = "Authorization"

    var key: String {
        self.rawValue
    }

}

protocol BaseNetworkClientProvider {

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

class BaseNetworkClient {

    static let baseApiUrl = URL(string: Api.baseUrl + Api.currentApiVersion)!

    private var urlSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.protocolClasses = [Interceptor.self]

        return URLSession(configuration: config)
    }()

    private lazy var encoder: JSONEncoder = {
        return JSONEncoder()
    }()

    private lazy var decoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private func encodeRequestBody<T: Encodable>(model: T) async throws -> Data {
        return try encoder.encode(model)
    }

    private func decodeResponseBody<T: Decodable>(type: T.Type, data: Data) async throws -> T {
        return try decoder.decode(T.self, from: data)
    }

    private func validateResponse(response: URLResponse) async throws {
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

    private func createRequest<T: Encodable>(
        method: HttpMethod,
        url: URL,
        headers: [String: String]?,
        params: [String: String]?,
        requestBody: T?
    ) async throws -> URLRequest {

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let requestBody = requestBody {
            guard let encodedBody = try? await encodeRequestBody(model: requestBody) else {
                throw NetworkError.bodyFormatError
            }

            request.httpBody = encodedBody
        }

        return request
    }

}

extension BaseNetworkClient: BaseNetworkClientProvider {

    func get<T: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String],
        responseType: T.Type
    ) async throws -> T {

        let (data, response) = try await urlSession.data(from: url)

        try await validateResponse(response: response)

        let responseModel = try await decodeResponseBody(type: T.self, data: data)

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

        try await validateResponse(response: response)

        let responseModel = try await decodeResponseBody(type: U.self, data: data)

        return responseModel
    }

}
