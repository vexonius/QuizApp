enum Category: String, CaseIterable {

    case uncategorized
    case sport = "SPORT"
    case movies = "MOVIES"

    var named: String {
        switch self {
        case .uncategorized:
            return LocalizedStrings.all.localizedString
        default:
            return self.rawValue
        }
    }

}
