enum HttpMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"

    var string: String {
        return self.rawValue
    }

}

enum NetworkError: Error {

    case badURL
    case bodyFormatError
    case responseCorrupted
    case serverError

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
