import Foundation

class Interceptor: URLProtocol {

    weak var currentTask: URLSessionDataTask?

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)

        return session
    }()

    override class func canInit(with request: URLRequest) -> Bool {
        guard
            let lastPathComponent = request.url?.lastPathComponent,
            lastPathComponent != LoginEndpoints.login.rawValue
        else { return false }

        return request.value(forHTTPHeaderField: HeaderField.authorization.key) == nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    // Unfortunately, this is the only way to create global interceptor for all requests
    override func startLoading() {

        var newRequest = request

        if newRequest.value(forHTTPHeaderField: HeaderField.authorization.key) == nil {
            // TODO: receive token from keychain, in progress
            let token = "token"

            newRequest.setValue(
                String(format: Api.JWTtokenFormat, token), forHTTPHeaderField: HeaderField.authorization.key)
        }

        currentTask = session.dataTask(with: newRequest)
        currentTask?.resume()
    }

    override func stopLoading() {
        currentTask?.cancel()
    }

}

extension Interceptor: URLSessionDataDelegate {

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let client = client else { return }

        guard let response = task.response else {
            if let error = error {
                client.urlProtocol(self, didFailWithError: error)
            }

            return client.urlProtocolDidFinishLoading(self)
        }

        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client.urlProtocolDidFinishLoading(self)
    }

}
