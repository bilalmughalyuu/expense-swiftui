import SwiftUI
import SwiftData

@main
struct tasksappApp: App {
    @AppStorage("selectedTheme") private var themeRawValue: String = AppTheme.system.rawValue
    private var selectedTheme: AppTheme {
        AppTheme(rawValue: themeRawValue) ?? .system
    }
//    @State private var themeUpdater = UUID()
    @StateObject private var signinViewModel = SigninViewModel()
    @StateObject private var signupViewModel = SignupViewModel()
    @StateObject private var navigationCordinator = NavigationCoordinator()
    @StateObject private var addExpenseViewModel = AddExpenseViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var rootViewModel = RootViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .id(themeUpdater)
                .environmentObject(signinViewModel)
                .environmentObject(signupViewModel)
                .environmentObject(addExpenseViewModel)
                .environmentObject(homeViewModel)
                .environmentObject(rootViewModel)
                .environmentObject(navigationCordinator)
                .preferredColorScheme(
                    selectedTheme == .light ? .light :
                        selectedTheme == .dark ? .dark :
                        nil
                )
//                .onChange(of: themeRawValue) {
//                    themeUpdater = UUID()
//                }
        }
        .modelContainer(for: Expense.self)
    }
}
