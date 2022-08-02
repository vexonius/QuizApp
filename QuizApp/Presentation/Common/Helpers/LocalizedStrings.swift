import Foundation

enum LocalizedStrings: String {

    case appName = "PopQuiz"
    case emailPlaceholder = "Email"
    case passwordPlaceholder = "Password"
    case loginButtonTitle = "Login"
    case quiz = "Quiz"
    case settings = "Settings"

    case unauthorizedLoginErrorMessage = "Invalid email/password entered. \nPlease try again"
    case serverErrorMessage = "Something went wrong. \n Please try again later"

    var localizedString: String {
        self.rawValue
    }

}
