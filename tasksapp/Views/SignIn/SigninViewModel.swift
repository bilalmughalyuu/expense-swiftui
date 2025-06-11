import Foundation

class SigninViewModel: ObservableObject {
    @Published var email: String = "bilal@yahoo.com"
    @Published var password: String = "12345"
    
    var navigation: NavigationCoordinator?
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        
        let savedEmail = UserDefaults.standard.string(forKey: Constants.EMAIL_KEY)
        let savedPassword = UserDefaults.standard.string(forKey: Constants.PASSWORD_KEY)
        
        if self.email == savedEmail && self.password == savedPassword {
            navigation?.popToRoot()
            navigation?.push(.root)
        } else {
            print("Something went wrong")
        }
    }
}
