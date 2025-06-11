import SwiftUI
import SwiftData

@main
struct tasksappApp: App {
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
        }
        .modelContainer(for: Expense.self)
    }
}
