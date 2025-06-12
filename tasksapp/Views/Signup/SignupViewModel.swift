import Foundation

class SignupViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSubmitted: Bool = false
    
    var navigation: NavigationCoordinator?
    
    func signup() {
        isSubmitted = true
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        UserDefaults.standard.set(email, forKey: Constants.EMAIL_KEY)
        UserDefaults.standard.set(password, forKey: Constants.PASSWORD_KEY)
        navigation?.push(.root)
    }
}
