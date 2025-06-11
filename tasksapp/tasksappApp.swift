import SwiftUI
import SwiftData

@main
struct tasksappApp: App {
    @StateObject private var signinViewModel = SigninViewModel()
    @StateObject private var signupViewModel = SignupViewModel()
    @StateObject private var navigationCordinator = NavigationCoordinator()
    @StateObject private var addExpenseViewModel = AddExpenseViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(signinViewModel)
                .environmentObject(signupViewModel)
                .environmentObject(addExpenseViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(navigationCordinator)
        }
        .modelContainer(for: Expense.self)
    }
}
