import Foundation

enum LocalizedStrings: String {

    case appName = "PopQuiz"
    case emailPlaceholder = "Email"
    case usernamePlaceholder = "Username"
    case passwordPlaceholder = "Password"
    case loginButtonTitle = "Login"
    case logoutButtonTitle = "Logout"
    case quiz = "Quiz"
    case settings = "Settings"
    case error = "Error"
    case networkError = "Network Error"
    case networkErrorDescription = "Data can’t be reached. \nPlease try again"

    case unauthorizedLoginErrorMessage = "Invalid email/password entered. \nPlease try again"
    case serverErrorMessage = "Something went wrong. \n Please try again later"

    var localizedString: String {
        self.rawValue
    }

}
