import Foundation

extension URLRequest {

    mutating func append(headers: [String: String]) {
        guard !headers.isEmpty else { return }

        headers.forEach { (key, value) in
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}
