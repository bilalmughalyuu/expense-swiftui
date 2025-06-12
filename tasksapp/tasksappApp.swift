import SwiftUI
import SwiftData

@main
struct tasksappApp: App {
    @AppStorage(Constants.COLOR_SCHEME_KEY) private var selectedTheme: AppTheme = .system
    
    @StateObject private var signinViewModel = SigninViewModel()
    @StateObject private var signupViewModel = SignupViewModel()
    @StateObject private var navigationCordinator = NavigationCoordinator()
    @StateObject private var addExpenseViewModel = AddExpenseViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var rootViewModel = RootViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(signinViewModel)
                .environmentObject(signupViewModel)
                .environmentObject(addExpenseViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(rootViewModel)
                .environmentObject(navigationCordinator)
                .preferredColorScheme(selectedTheme.colorScheme)
        }
        .modelContainer(for: Expense.self)
    }
}
