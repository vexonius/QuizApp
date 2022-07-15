import Foundation

enum LocalizedStrings: String {

    case appName = "PopQuiz"
    case emailPlaceholder = "Email"
    case passwordPlaceholder = "Password"
    case loginButtonTitle = "Login"

    var localizedString: String {
        self.rawValue
    }

}
