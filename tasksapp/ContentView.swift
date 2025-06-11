import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            SigninView()
                .navigationDestination(for: LoginNavigation.self) { destination in
                    switch destination {
                    case .signup:
                        SignupView()
                            .navigationBarBackButtonHidden(true)
                    case .root:
                        RootView()
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NavigationCoordinator())
        .environmentObject(SigninViewModel())
}
