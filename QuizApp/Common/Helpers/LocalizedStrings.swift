import Foundation

enum LocalizedStrings: String {

    case appName = "PopQuiz"
    case emailPlaceholder = "Email"
    case passwordPlaceholder = "Password"

    var localizedString: String {
        self.rawValue
    }

}
