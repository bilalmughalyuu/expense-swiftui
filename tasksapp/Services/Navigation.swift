import SwiftUI

enum LoginNavigation: Hashable {
//    case login
    case signup
    case root
}

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func push(_ destination: LoginNavigation) {
        path.append(destination)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
