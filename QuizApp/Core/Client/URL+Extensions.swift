import Foundation

extension URL {

    func appending(queryItems: [String: String]) -> URL {

        guard !queryItems.isEmpty else { return self }

        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return self
        }

        let queryItems = queryItems.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        urlComponents.queryItems = queryItems

        return urlComponents.url!
    }

}
