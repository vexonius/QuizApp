import Foundation

class Interceptor: URLProtocol, URLSessionDelegate {

    override class func canInit(with request: URLRequest) -> Bool {
        guard
            let lastPathComponent = request.url?.lastPathComponent,
            lastPathComponent != LoginEndpoints.login.rawValue
        else { return false }

        dump(request)

        return request.value(forHTTPHeaderField: HeaderField.authorization.rawValue) == nil
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {

        var newRequest = request

        if newRequest.value(forHTTPHeaderField: HeaderField.authorization.rawValue) == nil {
            let token = "token"

            newRequest.setValue(
                String(format: Api.JWTtokenFormat, token), forHTTPHeaderField: HeaderField.authorization.rawValue)
        }

        URLSession.shared.dataTask(with: newRequest as URLRequest) { [weak self] data, response, error in
            guard
                let self = self,
                let client = self.client
            else { return }

            if let error = error {
                client.urlProtocol(self, didFailWithError: error)
            }

            if let response = response {
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let data = data {
                client.urlProtocol(self, didLoad: data)
            }

            client.urlProtocolDidFinishLoading(self)
        }.resume()
    }

    override func stopLoading() {

    }

}
