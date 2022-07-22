enum HeaderField: String {

    case authorization = "Authorization"
    case contentType = "Content-Type"

    var key: String {
        self.rawValue
    }

}

enum HeaderValue: String {

    case defaultContentType = "application/json;charset=UTF-8"

    var value: String {
        self.rawValue
    }
}
